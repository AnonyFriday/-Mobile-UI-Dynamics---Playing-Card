//
//  CGRect.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 28/1/21.
//

import UIKit

extension CGRect {
    
    //MARK: Resize the bound and give the result of new CGRect, same center point
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = scale * self.width
        let newHeight = scale * self.height
        return insetBy(dx: (self.width - newWidth)/2, dy: (self.height - newHeight)/2)
    }
    
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
}
