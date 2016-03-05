//
//  BouncingBlocksViewController.swift
//  BouncingBlocks
//
//  Created by Jagadish Uppala on 3/4/16.
//  Copyright © 2016 Jagadish Uppala. All rights reserved.
//

import UIKit

class BouncingBlocksViewController: UIViewController, UIDynamicAnimatorDelegate {
    
    @IBOutlet weak var gameView: UIView!
    
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        lazilyCreatedDynamicAnimator.delegate = self
        return lazilyCreatedDynamicAnimator
    }()
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    let bouncingBehavior = BouncingBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(bouncingBehavior)
    }
    
    var blockSize: CGSize {
        let size = min(gameView.bounds.size.width, gameView.bounds.size.height) / CGFloat(GameSettings.blocksPerRow)
        return CGSize(width: size, height: size)
    }
    
    @IBAction func createBlock(sender: UITapGestureRecognizer) {
        block()
    }
    
    func block() {
        var frame = CGRect(origin: CGPointZero, size: blockSize)
        frame.origin.x = CGFloat.random(GameSettings.blocksPerRow) * blockSize.width
        
        let blockView = UIView(frame: frame)
        blockView.backgroundColor = UIColor.random
        bouncingBehavior.addBounceBehavior(blockView)
    }
    
    func removeCompletedRow() {
        var blocksToRemove = [UIView]()
        var blockFrame = CGRect(x: 0, y: gameView.frame.maxY, width: blockSize.width, height: blockSize.height)
        
        repeat {
            blockFrame.origin.x = 0
            blockFrame.origin.y -= blockSize.height
            var blocksFound = [UIView]()
            var isRowCompleted = true
            
            for _ in 0 ..< GameSettings.blocksPerRow {
                if let hitView = gameView.hitTest(CGPoint(x: blockFrame.midX, y: blockFrame.midY), withEvent: nil) {
                    if hitView.superview == gameView {
                        blocksFound.append(hitView)
                    } else {
                        isRowCompleted = false
                    }
                }
                blockFrame.origin.x += blockSize.width
            }
            
            if isRowCompleted {
                blocksToRemove += blocksFound
            }
        } while blocksToRemove.count == 0 && blockFrame.origin.y > 0
        
        for block in blocksToRemove {
            bouncingBehavior.removeBounceBehavior(block)
        }
    }
}

extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

extension UIColor {
    class var random: UIColor {
        switch arc4random() % 6 {
        case 0: return UIColor.blueColor()
        case 1: return UIColor.greenColor()
        case 2: return UIColor.brownColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.orangeColor()
        default: return UIColor.yellowColor()
        }
    }
}
