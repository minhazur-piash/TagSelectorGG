//
//  SuggestedTagSelectionViewController.swift
//  TagSelector
//
//  Created by minhaz on 1/15/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import UIKit
import TTGTagCollectionView


class SuggestedTagSelectionViewController: UIViewController {

    var tagManageDelegate: TagManageDelegate?
    
    @IBOutlet weak var suggestedTagsCollectionView: UICollectionView!
    fileprivate var tags = ["MANGO", "APPLE", "BANANA", "FRUITS", "MANGO", "FRUITS", "ORANGE", "DUMMY", "TEXT"]
    var selectedTags: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestedTagsCollectionView.dataSource = self
        suggestedTagsCollectionView.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 10
        suggestedTagsCollectionView.collectionViewLayout = layout
    }
    
    
    func isAlreadySelected(tag: String) -> Bool {
        return selectedTags.contains(tag)
    }
    
    func tagPressed(_ sender: TagView!) {
        sender.onTap?(sender)
        
        if isAlreadySelected(tag: sender.currentTitle!) {
            sender.isSelected = false
            selectedTags.remove(at: selectedTags.index(of: sender.currentTitle!)!)
            
            if let tagManager = tagManageDelegate {
                tagManager.tagRemoved(tag: sender.currentTitle!)
            }
            
        } else {
            sender.isSelected = true
            selectedTags.append(sender.currentTitle!)
            
            if let tagManager = tagManageDelegate {
                tagManager.tagSelected(tag: sender.currentTitle!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
}

extension SuggestedTagSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedTagsCollectionViewCell", for: indexPath) as! SuggestedTagsCollectionViewCell
        
        
        let aTagView = cell.suggestedTagView!
        aTagView.setTitle(tags[indexPath.row], for: .normal)
        aTagView.textFont = UIFont.systemFont(ofSize: 14)
        aTagView.paddingX = 15
        aTagView.textColor = Color.hexStringToUIColor(hex: Color.suggestedTagTextColor)
        aTagView.tagBackgroundColor = UIColor.white
        aTagView.highlightedBackgroundColor = UIColor.blue
        
        aTagView.selectedBackgroundColor = Color.hexStringToUIColor(hex: Color.appPrimaryColorLight)
        aTagView.selectedTextColor = UIColor.white
        aTagView.addTarget(self, action: #selector(tagPressed(_:)), for: .touchUpInside)
        
        return cell
    }

}

extension SuggestedTagSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = widthForString(text: tags[indexPath.row], font: UIFont.systemFont(ofSize: 16), height: 16) + 30
        return CGSize(width: cellWidth, height: 33)
    }
    
    
    func widthForString(text:String, font:UIFont, height:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
    
}
