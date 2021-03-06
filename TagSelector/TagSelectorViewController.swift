//
//  ViewController.swift
//  TagSelector
//
//  Created by minhazur rahman on 1/11/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import UIKit

protocol ScaleTagSelectorControllerDelegate {
    func scale()
}

protocol TagSearchDelegate {
    func searchTag(fitlerText: String)
}

protocol TagManageDelegate {
    func tagSelected(tag: GGSObject)
    func tagRemoved(tag: GGSObject)
}

class TagSelectorViewConroller: UIViewController, UISearchBarDelegate, TagManageDelegate {
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tagSearchBar: CustomSearchBar!
    @IBOutlet weak var tagsContainer: UIView!
    @IBOutlet weak var selectedTagsCollectionView: UICollectionView!
    @IBOutlet weak var selectedTagsContainerView: UIView!
    @IBOutlet weak var selectionReportLabel: UILabel!
    
    fileprivate var selectedTags: [GGSObject] = []
    var scaleDelegate: ScaleTagSelectorControllerDelegate?
    
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
        viewController.tagManagerDelegate = self
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.setTitleColor(Color.hexStringToUIColor(hex: Color.appPrimaryColorLight), for: .normal)
        selectedTagsContainerView.backgroundColor = Color.hexStringToUIColor(hex: Color.selectedTagContainerBackground)
        selectionReportLabel.textColor = Color.hexStringToUIColor(hex: Color.slectionReportLabelColor)
        selectionReportLabel.text = "No skills selected"
        
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
    
    
    //MARK:- searchbar delegate methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let delegate = scaleDelegate {
            delegate.scale()
        }
        
        remove(asChildViewController: suggestedTagSelectionViewController)
        add(asChildViewController: searchedTagSelectionViewController)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.childViewControllers[0] is SearchedTagSelectionViewController {
            (self.childViewControllers[0] as! TagSearchDelegate).searchTag(fitlerText: searchText)
        }
        
        controlAccessoryView()
    }
   
    
    func controlAccessoryView() {
        if TaskUtils.isEmpty(text: tagSearchBar.text) {
            hideAccessoryView()
            return
        }
        
        showAccessoryView()
    }
    
    func showAccessoryView() {
        tagSearchBar.inputAccessoryView = getAccessoryView(searchText: tagSearchBar.text!)
        tagSearchBar.reloadInputViews()
    }
    
    func hideAccessoryView() {
        tagSearchBar.inputAccessoryView = nil
        tagSearchBar.reloadInputViews()
    }
    
    func getAccessoryView(searchText: String) -> UIView {
        let addTagButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        addTagButton.setTitle("+ Add \"" + searchText + "\"", for: .normal)
        addTagButton.setTitleColor(Color.hexStringToUIColor(hex: Color.appPrimaryColorLight), for: .normal)
        addTagButton.addTarget(self, action: #selector(addTagButtonPressed(_:)), for: .touchUpInside)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
        view.addSubview(addTagButton)
        
        return view
        
    }
    
    func addTagButtonPressed(_ sender: UIButton) {
        debugPrint("pressed on " + sender.currentTitle!)
        let tagText = tagSearchBar.text
        if TaskUtils.isEmpty(text: tagText){
                return
        }
        tagSelected(tag: GGSObject(id: Int(arc4random()), name: tagText!))
        
    }
    
    func tagSelected(tag: GGSObject) {
     
        selectedTags.append(tag)
        selectedTagsCollectionView.reloadData()
        selectionReportLabel.isHidden = true
        
        // auto scroll collectionview item to right when new item added and content view is out of scrollable area
        selectedTagsCollectionView.scrollToItem(at: IndexPath(row: selectedTags.count - 1, section: 0), at: UICollectionViewScrollPosition.right, animated: true)
    }
    
    func tagRemoved(tag: GGSObject) {
        if let index = selectedTags.index(of: tag) {
            selectedTags.remove(at: index)
        }
        
        
        (suggestedTagSelectionViewController as TagManageDelegate).tagRemoved(tag: tag)
        selectedTagsCollectionView.reloadData()
        
        if selectedTags.count < 1 {
            selectionReportLabel.isHidden = false
        }
    }
}


extension TagSelectorViewConroller: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedTagsCollectionViewCell", for: indexPath) as! SelectedTagsCollectionViewCell
        
        let tagView = cell.selectedTagView!
        tagView.setTitle(selectedTags[indexPath.row].name, for: .normal)
        tagView.enableRemoveButton = true
        tagView.cornerRadius = 15
        tagView.textFont = UIFont.systemFont(ofSize: 14)
        tagView.paddingX = 10
        tagView.textColor = UIColor.white
        tagView.tagBackgroundColor = Color.hexStringToUIColor(hex: Color.appPrimaryColorLight)
       
        tagView.removeButtonOvalSize = 22
        tagView.removeButtonOvalColor = Color.hexStringToUIColor(hex: Color.appPrimaryColorDark)
        tagView.removeButtonIconSize = 8
        tagView.removeIconLineWidth = 1
        tagView.removeButton.tag = indexPath.row
        tagView.removeButton.addTarget(self, action: #selector(tagRemovePressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func isAlreadySelected(tag: GGSObject) -> Bool {
        return selectedTags.contains(tag)
    }
    
    func tagRemovePressed(_ closeButton: CloseButton!) {
        tagRemoved(tag: selectedTags[closeButton.tag])
        
    }
}

extension TagSelectorViewConroller: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = widthForString(text: selectedTags[indexPath.row].name, font: UIFont.systemFont(ofSize: 14), height: 14) + 50
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
