//
//  CloseButton.swift
//  TagListViewDemo
//
//  Created by Benjamin Wu on 2/11/16.
//  Copyright © 2016 Ela. All rights reserved.
//

import UIKit

internal class CloseButton: UIButton {

    var iconSize: CGFloat = 10
    var ovalSize: CGFloat = 10
    var ovalColor: UIColor = UIColor.darkGray
    var lineWidth: CGFloat = 1
    var lineColor: UIColor = UIColor.white.withAlphaComponent(0.54)

    weak var tagView: TagView?

    override func draw(_ rect: CGRect) {
       
        let ovalFrame = CGRect(
            x: (rect.width - ovalSize) / 2.0,
            y: (rect.height - ovalSize) / 2.0,
            width: ovalSize,
            height: ovalSize
        )
        
        let ovalPath = UIBezierPath(ovalIn: ovalFrame)
        ovalColor.setFill()
        ovalPath.fill()
        
        
        let iconFrame = CGRect(
            x: (rect.width - iconSize) / 2.0,
            y: (rect.height - iconSize) / 2.0,
            width: iconSize,
            height: iconSize
        )
        let crossPath = UIBezierPath()
        crossPath.lineWidth = lineWidth
        crossPath.lineCapStyle = .round
        
        
        
        crossPath.move(to: iconFrame.origin)
        crossPath.addLine(to: CGPoint(x: iconFrame.maxX, y: iconFrame.maxY))
        crossPath.move(to: CGPoint(x: iconFrame.maxX, y: iconFrame.minY))
        crossPath.addLine(to: CGPoint(x: iconFrame.minX, y: iconFrame.maxY))
        
        lineColor.setStroke()
        
        crossPath.stroke()
    }

}
