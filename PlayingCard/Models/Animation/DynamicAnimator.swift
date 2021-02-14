

import UIKit

class DynamicAnimator: UIDynamicBehavior
{
    
    //MARK: Initialize those Behavior
//    private lazy var gravityBehavior : UIGravityBehavior! = {
//        var gravity = UIGravityBehavior()
//        gravity.angle = CGFloat.pi / 2
//        gravity.magnitude = CGFloat.pi
//        return gravity
//    }()
    
    
    private lazy var collisionBehavior : UICollisionBehavior! = {
        var collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionMode = .everything
        return collision
    }()
    
    
    private lazy var itemBehavior      : UIDynamicItemBehavior! = {
        var itemBehavior = UIDynamicItemBehavior()
        itemBehavior.allowsRotation  = true
        itemBehavior.elasticity      = 1.0
        itemBehavior.resistance      = 0
        return itemBehavior
    }()
    
    
    func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.magnitude = CGFloat(1.0) + CGFloat(2.0).arc4random
        push.angle     = (2 * CGFloat.pi).arc4random
        push.action = {[unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }
    
    
    func addItem(item: UIDynamicItem) {
//        gravityBehavior.addItem(item)
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        push(item)
    }
    
    
    func removeItem(item: UIDynamicItem) {
//        gravityBehavior.removeItem(item)
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
        push(item)
    }
    
    
    //MARK: Init Add ChildBehavior
    override init() {
        super.init()
//        addChildBehavior(gravityBehavior)
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    
    //MARK: Convenience Init Add Behavior to Animator
    convenience init(animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}
