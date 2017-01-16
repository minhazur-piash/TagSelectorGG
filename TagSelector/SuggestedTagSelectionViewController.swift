//
//  SuggestedTagSelectionViewController.swift
//  TagSelector
//
//  Created by minhaz on 1/15/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import UIKit

class SuggestedTagSelectionViewController: UIViewController, TagListViewDelegate {

    @IBOutlet weak var suggestedTagsView: TagListView!
    var tagManageDelegate: TagManageDelegate?
    
    
    fileprivate var tags = ["MANGO", "APPLE", "BANANA", "FRUITS", "MANGO", "FRUITS", "ORANGE", "DUMMY", "TEXT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        suggestedTagsView.delegate = self
        suggestedTagsView.textFont = UIFont.systemFont(ofSize: 15)
        suggestedTagsView.tagSelectedBackgroundColor = Color.hexStringToUIColor(hex: Color.suggestedTagSelectionBackgroundColor)
        
        suggestedTagsView.addTags(tags)
        
        suggestedTagsView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
        
        if let tagManager = tagManageDelegate {
            tagManager.tagSelected(tag: title)
        }
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
        
        if let tagManager = tagManageDelegate {
            tagManager.tagRemoved(tag: title)
        }
    }

}
