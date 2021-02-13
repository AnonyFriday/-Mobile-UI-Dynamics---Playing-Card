//
//  UIView+Ext.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 26/1/21.
//

import UIKit

extension UIView {
    func addSubViews(views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}

extension UIView {
    // Sequencial Animation
    func animate(_ animations: [Animation]) {
        guard !animations.isEmpty else { return }
        
        // remove the first animation
        var arrAnimations = animations
        let firstAnimation = arrAnimations.removeFirst()
        
        UIView.animate(withDuration: firstAnimation.duration,
                       delay: firstAnimation.delay,
                       options: firstAnimation.options,
                       animations: { firstAnimation.closure(self) },
                       completion: { _ in self.animate(arrAnimations) }
        )
    }
    
    
    // Parallel Animation
    func animate(inParallel animations: [Animation]) {
        for animation in animations {
            UIView.animate(withDuration: animation.duration, delay: animation.delay, options: animation.options) {
                animation.closure(self)
            }
        }
    }
    
}



