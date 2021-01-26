//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 26/1/21.
//

import UIKit

class PlayingCardView: UIView
{
    private var upperLeftCornerLabel  : KD
    private var lowerRightCornelLabel : UILabel
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Draw
    override func draw(_ rect: CGRect) {
        // Using UIBezierPath
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 24)
        UIColor.white.setFill()
        path.addClip()
        path.fill()
    }
 

}

extension PlayingCardView
{
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight : CGFloat = 0.06
    }
    
    private var cornerRadius : CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
}
