//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 26/1/21.
//

import UIKit

@IBDesignable
class KDPlayingCardView: UIView
{
    @IBInspectable var rank:       Int     = 5 { didSet { setNeedsLayout(); setNeedsDisplay() }}
    @IBInspectable var suit:       String  = "♠️" { didSet { setNeedsLayout(); setNeedsDisplay() }}
    @IBInspectable var isFaceUp:   Bool    = true { didSet { setNeedsLayout(); setNeedsDisplay() }}
    
    
    var faceCardScale: CGFloat = SizeRatio.faceCardImageSizeToBoundsSize { didSet { setNeedsDisplay() } }
    
    private var centerStringLabel : NSAttributedString {
        return NSAttributedString.createCenterAttributedString(rankString+"\n"+suit, fontSize: cornerFontSize)
    }
    
    private lazy var upperLeftCornerLabel  = KDCornerLabel(attributedString: centerStringLabel)
    private lazy var lowerRightCornelLabel = KDCornerLabel(attributedString: centerStringLabel)
    
    //MARK: Required Initializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubViews(views: upperLeftCornerLabel, lowerRightCornelLabel)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViews(views: upperLeftCornerLabel, lowerRightCornelLabel)
    }
    
    
    
    //MARK: Code does something that the bound changed
    /// setNeedsLayout trigger layoutSubviews
    /// Used to determine the position of my subviews when my view's bound changed
    /// Recommend to put all those constraints, layout inside this line of code
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
        UIColor.white.setFill()
        path.addClip()
        path.fill()
        
        //Draw Image inside the view's bound ( 11,12,13 )
        switch isFaceUp {
            case true:
                if let image = ImageFromXCAssets.cardFaceUpCardImage(rankString+suit) {
                    image.draw(in: bounds.zoom(by: faceCardScale))
                } else {
                    drawPips()
                }
            case false:
                ImageFromXCAssets.cardBackImage.draw(in: bounds)
        }
        
    }
    
    
    //MARK: Trail Collection Redraw
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }


    //MARK: Configure Upper Left Corner Label
    fileprivate func configureUpperLeftCornerLabel() {
        upperLeftCornerLabel.attributedText = centerStringLabel
        upperLeftCornerLabel.resetToFitFontSizeDynamically()
        
        upperLeftCornerLabel.frame.origin = self.bounds.origin.offSetBy(dx: cornerOffset, dy: cornerOffset)
        upperLeftCornerLabel.isHidden     = !isFaceUp
    }
    
    //MARK: Configure Lower Right Corner Label
    fileprivate func configureLowerRightCornerLabel() {
        lowerRightCornelLabel.attributedText = centerStringLabel
        lowerRightCornelLabel.resetToFitFontSizeDynamically()
        
        print(centerStringLabel)
        lowerRightCornelLabel.transform    = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornelLabel.frame.size.width, y: lowerRightCornelLabel.frame.size.height)
            .rotated(by: CGFloat.pi)
        lowerRightCornelLabel.frame.origin = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
            .offSetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offSetBy(dx: -lowerRightCornelLabel.frame.size.width, dy: -lowerRightCornelLabel.frame.size.height)
        
        lowerRightCornelLabel.isHidden     = !isFaceUp
    }

    
    //MARK: Draw pips on the card
    func drawPips() {
        let pipsPerRowForRank = [[0],[1],[1,1],[1,1,1],[2,2],[2,1,2],[2,2,2],[2,1,2,2],[2,2,2,2],[2,2,1,2,2],[2,2,2,2,2]]
        
        func createPipString(thatFits pipRect: CGRect) -> NSAttributedString {
            let maxVerticalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.count, $0)  })
            let maxHorizontalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.max() ?? 0, $0) })
            let verticalPipRowSpacing = pipRect.size.height / maxVerticalPipCount
            let attemptedPipString = NSAttributedString.createCenterAttributedString(suit, fontSize: verticalPipRowSpacing)
            let probablyOkayPipStringFontSize = verticalPipRowSpacing / (attemptedPipString.size().height / verticalPipRowSpacing)
            let probablyOkayPipString = NSAttributedString.createCenterAttributedString(suit, fontSize: probablyOkayPipStringFontSize)
            if probablyOkayPipString.size().width > pipRect.size.width / maxHorizontalPipCount {
                return NSAttributedString.createCenterAttributedString(suit, fontSize: probablyOkayPipStringFontSize / (probablyOkayPipString.size().width / (pipRect.size.width / maxHorizontalPipCount)))
            } else {
                return probablyOkayPipString
            }
        }
        
        // Check the rank that fits each item of the array
        if pipsPerRowForRank.indices.contains(rank) {
            let pipsPerRow = pipsPerRowForRank[rank]
            var pipRect = bounds.insetBy(dx: cornerOffset, dy: cornerOffset).insetBy(dx: upperLeftCornerLabel.bounds.width, dy: upperLeftCornerLabel.bounds.height / 2)
            let pipString = createPipString(thatFits: pipRect)
            let pipRowSpacing = pipRect.size.height / CGFloat(pipsPerRow.count)
            pipRect.size.height = pipString.size().height
            pipRect.origin.y += (pipRowSpacing - pipRect.size.height) / 2

            for pipCount in pipsPerRow {
                switch pipCount {
                case 1:
                    pipString.draw(in: pipRect)
                case 2:
                    pipString.draw(in: pipRect.leftHalf)
                    pipString.draw(in: pipRect.rightHalf)
                default:
                    break
                }
                pipRect.origin.y += pipRowSpacing
            }
        }
        
        
    }
}


//MARK: Extension
extension KDPlayingCardView
{
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight    : CGFloat  = 0.06
        static let cornerFontSizeToBoundHeight   : CGFloat  = 0.085
        static let cornerOffsetToCornerRadius    : CGFloat  = 0.33
        static let faceCardImageSizeToBoundsSize : CGFloat  = 0.75
        static let pipsFontSizeToSpacePerRow     : CGFloat  = 0.6
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
            default : return "?"
        }
    }
    
}





