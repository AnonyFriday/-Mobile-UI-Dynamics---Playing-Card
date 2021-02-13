//
//  Animation.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 13/2/21.
//

import UIKit

struct Animation {
    public var duration    : TimeInterval
    public var delay       : TimeInterval
    public var options     : UIView.AnimationOptions
    public var dampRatio   : CGFloat
    public var closure     : (UIView) -> ()
}

extension Animation {
    static func fadeOut(duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration,
                         delay: 0,
                         options: [],
                         dampRatio: 0) {  $0.alpha = 0.01 }
    }
    
    static func zoom(duration: TimeInterval = 0.3, sx: CGFloat, sy: CGFloat) -> Animation {
        return Animation(duration: duration,
                         delay: 0,
                         options: [],
                         dampRatio: 0)
        {
            $0.transform = CGAffineTransform.identity.scaledBy(x: sx, y: sy)
        }
    }
    
}

