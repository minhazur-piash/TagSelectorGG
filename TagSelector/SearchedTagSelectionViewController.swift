//
//  SearchedTagSelectionViewController.swift
//  TagSelector
//
//  Created by minhaz on 1/15/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import UIKit

class SearchedTagSelectionViewController: UIViewController, TagSearchDelegate {

    @IBOutlet weak var searchedTagsTableView: UITableView!
    
    fileprivate var items = ["dummy1", "dummy2", "dummy3", "dummy4", "dummy5", "dummyText", "dummy item", "dummy skill", "dummy text", "dummy ep"]
    fileprivate var filteredItems: [String] = []
    fileprivate var toFilterText: String?
    
    var tagManagerDelegate: TagManageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchedTagsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchTag(fitlerText filterText: String) {
        debugPrint("to filter text: " + filterText)
        
        toFilterText = filterText
        
        filteredItems = items.filter { (aItem) -> Bool in
            return aItem.localizedCaseInsensitiveContains(toFilterText!)
        }
        searchedTagsTableView.reloadData()
        
    }
}

extension SearchedTagSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEmpty(text: toFilterText) {
            return items.count
        } else {
            return filteredItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var itemsToShow = getCurrentTags()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedTagsTableViewCell", for: indexPath) as! SearchedTagsTableViewCell
        cell.tagLabel.text = itemsToShow[indexPath.row]
        
        cell.addTagButton.tag = indexPath.row
        cell.addTagButton.addTarget(self, action: #selector(addTagButtonPressed(_:)), for: .touchUpInside)
        return cell
    }
    
    func addTagButtonPressed(_ sender: UIButton) {
        let addedTag = getCurrentTags()[sender.tag]
        
        if let tagManager = tagManagerDelegate {
            tagManager.tagSelected(tag: addedTag)
        }
    }
    
    func isEmpty(text: String?) -> Bool {
        if text == nil || text!.isEmpty {
            return true
        }
        
        return false
    }
    
    func getCurrentTags() -> [String] {
        var itemsToShow: [String] = []
        if isEmpty(text: toFilterText) {
            itemsToShow = items
        } else {
            itemsToShow = filteredItems
        }
        
        return itemsToShow

    }
}
