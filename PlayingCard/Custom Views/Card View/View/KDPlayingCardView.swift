//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 26/1/21.
//

import UIKit

class PlayingCardView: UIView
{
    
    private lazy var upperLeftCornerLabel  = KDCornerLabel(string: rankString+"\n"+suit, fontSize: cornerFontSize)
    private lazy var lowerRightCornelLabel = KDCornerLabel(string: rankString+"\n"+suit, fontSize: cornerFontSize)
    
    var rank:       Int     = 5 { didSet { setNeedsLayout(); setNeedsDisplay() }}
    var suit:       String  = "❤️" { didSet { setNeedsLayout(); setNeedsDisplay() }}
    var isFaceUp:   Bool    = true { didSet { setNeedsLayout(); setNeedsDisplay() }}
    
    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(views: upperLeftCornerLabel,lowerRightCornelLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK: Draw
    override func draw(_ rect: CGRect) {
        // Using UIBezierPath
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        UIColor.white.setFill()
        path.addClip()
        path.fill()
    }
    
    
}


//MARK: Extension
extension PlayingCardView
{
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight : CGFloat     = 0.06
        static let cornerFontSizeToBoundHeight : CGFloat    = 0.085
        static let cornerOffsetToCornerRadius  : CGFloat    = 0.33
        static let faceCardImageSizeToBoundsSize : CGFloat  = 0.75
    }
    
    private var cornerRadius : CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset : CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundHeight
    }
    
    private var rankString: String {
        switch rank {
            case 1: return "A"
            case 2...10: return String(rank)
            case 11 : return "J"
            case 12 : return "Q"
            case 13 : return "K"
            default : return "/"
        }
    }
}
