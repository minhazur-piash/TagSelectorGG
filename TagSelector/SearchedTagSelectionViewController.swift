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
    
    fileprivate var items = TagGenerator.getTags()
    fileprivate var filteredItems: [GGSObject] = []
    fileprivate var toFilterText: String?
    
    var tagManagerDelegate: TagManageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchedTagsTableView.dataSource = self
        searchedTagsTableView.delegate = self
        
        //add more scrollable spaces below
        searchedTagsTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 150, right: 0)
    }

    func searchTag(fitlerText filterText: String) {
        toFilterText = filterText
        
        filteredItems = items.filter { (aItem) -> Bool in
            return aItem.name.localizedCaseInsensitiveContains(toFilterText!)
        }
        searchedTagsTableView.reloadData()
    }
}


extension SearchedTagSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK:- table view data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if TaskUtils.isEmpty(text: toFilterText) {
            return items.count
        } else {
            return filteredItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var itemsToShow = getCurrentTags()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedTagsTableViewCell", for: indexPath) as! SearchedTagsTableViewCell
        cell.tagLabel.text = itemsToShow[indexPath.row].name
        
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
    
    //MARK:- table view delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addedTag = getCurrentTags()[indexPath.row]
        
        if let tagManager = tagManagerDelegate {
            tagManager.tagSelected(tag: addedTag)
        }
    }
    
    
    func getCurrentTags() -> [GGSObject] {
        var itemsToShow: [GGSObject] = []
        if TaskUtils.isEmpty(text: toFilterText) {
            itemsToShow = items
        } else {
            itemsToShow = filteredItems
        }
        
        return itemsToShow
    }
}
