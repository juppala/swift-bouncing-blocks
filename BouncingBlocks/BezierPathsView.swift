//
//  BezierPathsView.swift
//  BouncingBlocks
//
//  Created by Jagadish Uppala on 3/4/16.
//  Copyright © 2016 Jagadish Uppala. All rights reserved.
//

import UIKit

class BezierPathsView: UIView {

    private var bezierPaths = [String:UIBezierPath]()
    
    func setPath(name: String, path: UIBezierPath?) {
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }

}
