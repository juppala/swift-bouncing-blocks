//
//  BouncingBehavior.swift
//  BouncingBlocks
//
//  Created by Jagadish Uppala on 3/4/16.
//  Copyright © 2016 Jagadish Uppala. All rights reserved.
//

import UIKit

class BouncingBehavior: UIDynamicBehavior {
    
    let gravity = UIGravityBehavior()
    
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
    }()
    
    lazy var blockBounceBehavior: UIDynamicItemBehavior = {
        let lazilyCreatedBlockBounceBehavior = UIDynamicItemBehavior()
        lazilyCreatedBlockBounceBehavior.allowsRotation = true
        lazilyCreatedBlockBounceBehavior.elasticity = 0.75
        return lazilyCreatedBlockBounceBehavior
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(blockBounceBehavior)
    }
    
    func addBarrier(name:String, path: UIBezierPath) {
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    func addBounceBehavior(blockView: UIView) {
        self.dynamicAnimator?.referenceView?.addSubview(blockView)
        gravity.addItem(blockView)
        collider.addItem(blockView)
        blockBounceBehavior.addItem(blockView)
    }
    
    func removeBounceBehavior(blockView: UIView) {
        gravity.removeItem(blockView)
        collider.removeItem(blockView)
        blockBounceBehavior.removeItem(blockView)
        blockView.removeFromSuperview()
    }
}
