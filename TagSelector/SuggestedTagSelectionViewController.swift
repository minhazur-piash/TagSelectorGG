//
//  SuggestedTagSelectionViewController.swift
//  TagSelector
//
//  Created by minhaz on 1/15/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import UIKit
import TTGTagCollectionView


class SuggestedTagSelectionViewController: UIViewController, TagManageDelegate {

    var tagManageDelegate: TagManageDelegate?
    
    @IBOutlet weak var suggestedTagsCollectionView: UICollectionView!
    fileprivate var suggestedTags = TagGenerator.getTags()
    var selectedTags: [GGSObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestedTagsCollectionView.dataSource = self
        suggestedTagsCollectionView.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 10
        suggestedTagsCollectionView.collectionViewLayout = layout
    }
    
    func tagSelected(tag: GGSObject) {}
    
    func tagRemoved(tag: GGSObject) {
        if let index = selectedTags.index(of: tag) {
            selectedTags.remove(at: index)
        }
        suggestedTagsCollectionView.reloadData()
    }
    
    
    func isAlreadySelected(tag: GGSObject) -> Bool {
        return selectedTags.contains(tag)
    }
    
    func tagPressed(_ sender: TagView!) {
        sender.onTap?(sender)
        
        let selectedTag = suggestedTags[sender.tag]
        if isAlreadySelected(tag: selectedTag) {
            sender.isSelected = false
            selectedTags.remove(at: selectedTags.index(of: selectedTag)!)
            
            if let tagManager = tagManageDelegate {
                tagManager.tagRemoved(tag: selectedTag)
            }
            
        } else {
            sender.isSelected = true
            selectedTags.append(selectedTag)
            
            if let tagManager = tagManageDelegate {
                tagManager.tagSelected(tag: selectedTag)
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
        return suggestedTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedTagsCollectionViewCell", for: indexPath) as! SuggestedTagsCollectionViewCell
        
        
        let aTagView = cell.suggestedTagView!
        
        if isAlreadySelected(tag: suggestedTags[indexPath.row]) {
            aTagView.isSelected = true
        } else {
            aTagView.isSelected = false
        }
        
        aTagView.setTitle(suggestedTags[indexPath.row].name, for: .normal)
        aTagView.textFont = UIFont.systemFont(ofSize: 14)
        aTagView.paddingX = 15
        aTagView.textColor = Color.hexStringToUIColor(hex: Color.suggestedTagTextColor)
        aTagView.tagBackgroundColor = UIColor.white
        aTagView.highlightedBackgroundColor = UIColor.blue
        
        aTagView.selectedBackgroundColor = Color.hexStringToUIColor(hex: Color.appPrimaryColorLight)
        aTagView.selectedTextColor = UIColor.white
        aTagView.tag = indexPath.row
        aTagView.addTarget(self, action: #selector(tagPressed(_:)), for: .touchUpInside)
        
        return cell
    }

}

extension SuggestedTagSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = widthForString(text: suggestedTags[indexPath.row].name, font: UIFont.systemFont(ofSize: 16), height: 16) + 30
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

class TagGenerator {
    static func getTags() -> [GGSObject] {
        var tags: [GGSObject] = []
        tags.append(GGSObject(id: 1, name: "PHP"))
        tags.append(GGSObject(id: 2, name: "JAVA"))
        tags.append(GGSObject(id: 3, name: "AJAX"))
        tags.append(GGSObject(id: 4, name: "CSS"))
        tags.append(GGSObject(id: 5, name: "HTML"))
        tags.append(GGSObject(id: 6, name: "Photography"))
        tags.append(GGSObject(id: 7, name: "Typography"))
        tags.append(GGSObject(id: 8, name: "Swift"))
        tags.append(GGSObject(id: 9, name: "Erlang"))
        tags.append(GGSObject(id: 10, name: "XMPP"))
        tags.append(GGSObject(id: 11, name: "Android"))
        tags.append(GGSObject(id: 12, name: "Javascript"))
        tags.append(GGSObject(id: 13, name: "Node"))
        tags.append(GGSObject(id: 14, name: "Angular"))
        tags.append(GGSObject(id: 15, name: "SAAS"))
        tags.append(GGSObject(id: 16, name: "Csharp"))
        tags.append(GGSObject(id: 17, name: "Unity"))
        tags.append(GGSObject(id: 18, name: "Laravel"))
        
        return tags
    }
}
