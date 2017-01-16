//
//  SuggestedTagSelectionViewController.swift
//  TagSelector
//
//  Created by minhaz on 1/15/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import UIKit
import TTGTagCollectionView


class SuggestedTagSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var tagManageDelegate: TagManageDelegate?
    
    @IBOutlet weak var suggestedTagsCollectionView: UICollectionView!
    fileprivate var tags = ["MANGO", "APPLE", "BANANA", "FRUITS", "MANGO", "FRUITS", "ORANGE", "DUMMY", "TEXT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestedTagsCollectionView.dataSource = self
        suggestedTagsCollectionView.delegate = self
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedTagsCollectionViewCell", for: indexPath) as! SuggestedTagsCollectionViewCell
        cell.suggestedTagView.setTitle(tags[indexPath.row], for: .normal)
        cell.suggestedTagView.textFont = UIFont.systemFont(ofSize: 16)
        cell.suggestedTagView.paddingX = 15
        cell.suggestedTagView.textColor = UIColor.gray
        cell.suggestedTagView.tagBackgroundColor = UIColor.white
        cell.suggestedTagView.selectedTextColor = UIColor.blue
//        cell.suggestedTagView.isSelected = true
        cell.suggestedTagView.highlightedBackgroundColor = UIColor.blue
        cell.suggestedTagView.selectedBackgroundColor = UIColor.green
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthForString(text: tags[indexPath.row], font: UIFont.systemFont(ofSize: 16), height: 16) + 35, height: 33)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
}
