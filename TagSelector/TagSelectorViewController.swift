//
//  ViewController.swift
//  TagSelector
//
//  Created by minhazur rahman on 1/11/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import UIKit

protocol TranslateControllerDelegate {
    func translate()
}

protocol TagSearchDelegate {
    func searchTag(fitlerText: String)
}

protocol TagManageDelegate {
    func tagSelected(tag: String)
    func tagRemoved(tag: String)
}

class TagSelectorViewConroller: UIViewController, UISearchBarDelegate, TagListViewDelegate, TagManageDelegate {
    
    @IBOutlet weak var tagSearchBar: CustomSearchBar!
    @IBOutlet weak var tagsContainer: UIView!
    @IBOutlet weak var selectedTagsListView: TagListView!
    
    private lazy var suggestedTagSelectionViewController: SuggestedTagSelectionViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SuggestedTagSelectionViewController") as! SuggestedTagSelectionViewController
        viewController.tagManageDelegate = self
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var searchedTagSelectionViewController: SearchedTagSelectionViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SearchedTagSelectionViewController") as! SearchedTagSelectionViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    var translateControllerDelegate: TranslateControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         tagSearchBar.delegate = self
        selectedTagsListView.delegate = self
        
        
        remove(asChildViewController: searchedTagSelectionViewController)
        add(asChildViewController: suggestedTagSelectionViewController)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        tagsContainer.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = tagsContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        translateControllerDelegate.translate()
        
        remove(asChildViewController: suggestedTagSelectionViewController)
        add(asChildViewController: searchedTagSelectionViewController)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.childViewControllers[0] is SearchedTagSelectionViewController {
            (self.childViewControllers[0] as! TagSearchDelegate).searchTag(fitlerText: searchText)
        }
    }
    
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
    
    func tagSelected(tag: String) {
        selectedTagsListView.addTag(tag)
    }
    
    func tagRemoved(tag: String) {
        selectedTagsListView.removeTag(tag)
    }
    
}


