

import UIKit

class DynamicAnimator: UIDynamicBehavior
{
    
    //Initialize those Behavior
    private lazy var gravityBehavior : UIGravityBehavior! = {
        var gravity = UIGravityBehavior()
        gravity.angle = CGFloat.pi / 2
        gravity.magnitude = CGFloat.pi
        return gravity
    }()
    
    
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
    
    
    func addItem(item: UIDynamicItem) {
        gravityBehavior.addItem(item)
        collisionBehavior.addItem(item)
        collisionBehavior.addItem(item)
    }
    
    func removeItem(item: UIDynamicItem) {
        gravityBehavior.removeItem(item)
        collisionBehavior.removeItem(item)
        collisionBehavior.removeItem(item)
    }
    
    
    //MARK: Init Add ChildBehavior
    override init() {
        super.init()
        addChildBehavior(gravityBehavior)
        addChildBehavior(collisionBehavior)
        addChildBehavior(collisionBehavior)
    }
    
    
    //MARK: Convenience Init Add Behavior to Animator
    convenience init(animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}
