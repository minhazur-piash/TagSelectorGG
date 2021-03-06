//
//  Color.swift
//  TagSelector
//
//  Created by minhazur rahman on 1/15/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import UIKit

class Color {
    static let suggestedTagSelectionBackgroundColor = "#1EACB8"
    static let appPrimaryColorLight = "#08ACB9"
    static let appPrimaryColorDark = "#137880"
    static let suggestedTagTextColor = "#797979"
    static let selectedTagContainerBackground = "#F2F2F2"
    static let slectionReportLabelColor = "#727272"
    
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )    }
}
