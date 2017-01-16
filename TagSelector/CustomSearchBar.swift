//
//  CustomSearchBar.swift
//  CustomSearchBar
//
//  Created by S.M.Moinuddin on 1/14/17.
//  Copyright © 2017 GagaGugu. All rights reserved.
//

import UIKit

@IBDesignable class CustomSearchBar: UISearchBar {

    @IBInspectable var preferredFont: UIFont = UIFont.systemFont(ofSize: 20.0)
    @IBInspectable var newHeight: CGFloat = 30
    
    @IBInspectable var textColor: UIColor = UIColor.black {
        didSet{
            guard let index = indexOfSearchFieldInSubviews() else{return}
            let searchField: UITextField = (subviews[0] ).subviews[index] as! UITextField
            searchField.textColor = textColor
            
        }
    }
    
    @IBInspectable var magnifyingGlassColor: UIColor? {
        didSet {
            guard let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField else{return}
            if let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
                //Magnifying glass
                glassIconView.image = glassIconView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                glassIconView.tintColor = magnifyingGlassColor
            }
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
            let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
            textFieldInsideSearchBarLabel?.textColor = placeholderColor
        }
    }
    
    /**
     *** In any case if KeyValue don't work in future
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray
     */
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        // Setting the searchBar background Image to Empty Image
        self.backgroundImage = UIImage()
        
        // Find the index of the search field in the search bar subviews.
        guard let index = indexOfSearchFieldInSubviews() else{return}
        // Access the search field
        let searchField: UITextField = (subviews[0] ).subviews[index] as! UITextField
        
        //MARK: Must Perform this operations in draw method
        var currentTextFieldBounds          = searchField.bounds
        currentTextFieldBounds.size.height  = newHeight
        searchField.bounds                  = currentTextFieldBounds
        searchField.borderStyle             = UITextBorderStyle.roundedRect
        searchField.autoresizingMask        = [.flexibleWidth, .flexibleHeight]
        searchField.font                    = preferredFont
        
        /**
         *** In any case if KeyValue don't work in future
        searchField.attributedPlaceholder   = NSAttributedString(string: self.placeholder!, attributes:[NSForegroundColorAttributeName : placeholderColor])
        */
        
        super.draw(rect)
    }
    
    convenience init(frame: CGRect, font: UIFont, textColor: UIColor) {
        self.init(frame: frame)
        
        self.frame      = frame
        preferredFont   = font
        self.textColor  = textColor
        
        searchBarStyle = UISearchBarStyle.default
        isTranslucent = false
    }
    
    //MARK:- Needed to solve auto layout crash issue
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Private Method
    private func indexOfSearchFieldInSubviews() -> Int! {
        // Uncomment the next line to see the search bar subviews.
        // print(subviews[0].subviews)
        
        var index: Int!
        let searchBarView = subviews[0] 
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self) {
                index = i
                break
            }
        }
        
        return index
    }
}
