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
    
    
    //MARK: Required Initializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubViews(views: upperLeftCornerLabel, lowerRightCornelLabel)
    }
    
    
    
    //MARK: Code does something that the bound changed
    /// setNeedsLayout trigger layoutSubviews
    /// Used to determine the position of my subviews when my view's bound changed
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUpperLeftCornerLabel()
        configureLowerRightCornerLabel()
    }
    
    
    
    
    //MARK: Draw
    /// Redraw when you call the setNeedsDisplay
    override func draw(_ rect: CGRect) {
        // Using UIBezierPath
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        print(cornerRadius)
        UIColor.white.setFill()
        path.addClip()
        path.fill()
    }
    
    
    
    //MARK: Configure Upper Left Corner Label
    fileprivate func configureUpperLeftCornerLabel() {
        upperLeftCornerLabel.frame.origin = self.bounds.origin.offSetBy(dx: cornerOffset, dy: cornerOffset)
        upperLeftCornerLabel.isHidden     = !isFaceUp
    }
    
    //MARK: Configure Lower Right Corner Label
    fileprivate func configureLowerRightCornerLabel() {
        lowerRightCornelLabel.frame.origin = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
            .offSetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offSetBy(dx: -lowerRightCornelLabel.frame.size.width, dy: -lowerRightCornelLabel.frame.size.height)
        
        lowerRightCornelLabel.isHidden     = !isFaceUp
        
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

extension CGPoint {
    func offSetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}