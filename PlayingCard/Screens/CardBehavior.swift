//
//  CardBehavior.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 10/2/21.
//

import UIKit

class CardBehavior: UIDynamicBehavior {
    
    lazy var collitionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
       
        return behavior
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = true
        behavior.elasticity     = 1.0
        behavior.resistance     = 0
 
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.angle = (2*CGFloat.pi)
        push.magnitude = CGFloat(1) + CGFloat(2).arc4random
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        
        addChildBehavior(push)
    }
    
    func addItem(_ item: UIDynamicItem) {
        collitionBehavior.addItem(item)
        itemBehavior.addItem(item)
        push(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collitionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
    }
    
    override init() {
        super.init()
        addChildBehavior(collitionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}
