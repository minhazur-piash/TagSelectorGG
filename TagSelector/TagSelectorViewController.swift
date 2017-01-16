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

class TagSelectorViewConroller: UIViewController, UISearchBarDelegate, TagManageDelegate {
    @IBOutlet weak var tagSearchBar: CustomSearchBar!
    @IBOutlet weak var tagsContainer: UIView!
    @IBOutlet weak var selectedTagsCollectionView: UICollectionView!
    
    fileprivate var selectedTags: [String] = []
    
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
        
        selectedTagsCollectionView.dataSource = self
        selectedTagsCollectionView.delegate = self
        
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

    
    func tagSelected(tag: String) {
        selectedTags.append(tag)
        selectedTagsCollectionView.reloadData()
    }
    
    func tagRemoved(tag: String) {
        selectedTags.remove(at: selectedTags.index(of: tag)!)
        selectedTagsCollectionView.reloadData()
    }
    
}


extension TagSelectorViewConroller: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedTagsCollectionViewCell", for: indexPath) as! SelectedTagsCollectionViewCell
        cell.selectedTagView.setTitle(selectedTags[indexPath.row], for: .normal)
        cell.selectedTagView.enableRemoveButton = true
        cell.selectedTagView.cornerRadius = 15
        cell.selectedTagView.textFont = UIFont.systemFont(ofSize: 14)
        cell.selectedTagView.paddingX = 10
        cell.selectedTagView.textColor = UIColor.white
        cell.selectedTagView.tagBackgroundColor = UIColor.blue
        cell.selectedTagView.removeButtonOvalSize = 22
        cell.selectedTagView.removeButtonIconSize = 12
        cell.selectedTagView.removeIconLineWidth = 1
        cell.selectedTagView.removeButton.addTarget(self, action: #selector(tagRemovePressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func isAlreadySelected(tag: String) -> Bool {
        return selectedTags.contains(tag)
    }
    
    func tagRemovePressed(_ closeButton: CloseButton!) {
        if let tagView = closeButton.tagView {
            selectedTags.remove(at: selectedTags.index(of: tagView.currentTitle!)!)
            selectedTagsCollectionView.reloadData()
        }
    }
}

extension TagSelectorViewConroller: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = widthForString(text: selectedTags[indexPath.row], font: UIFont.systemFont(ofSize: 14), height: 14) + 50
        return CGSize(width: cellWidth, height: 30)
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
