//
//  GGSCardView.swift
//  GGSCardView
//
//  Created by S.M.Moinuddin on 1/14/17.
//  Copyright © 2017 GagaGugu. All rights reserved.
//

import UIKit

@IBDesignable
class GGSCardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    
    @IBInspectable var shadowOffsetWidth: Int   = 0
    @IBInspectable var shadowOffsetHeight: Int  = 2
    @IBInspectable var shadowColor: UIColor?    = UIColor.black
    @IBInspectable var shadowOpacity: Float     = 0.3
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor   = shadowColor?.cgColor
        layer.shadowOffset  = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath    = shadowPath.cgPath
    }
    
}

