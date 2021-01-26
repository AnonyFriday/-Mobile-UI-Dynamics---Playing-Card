//
//  KDLabel.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 26/1/21.
//

import UIKit

class KDCornerLabel: UILabel {

    var cornerString: NSAttributedString?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(string: String, fontSize: CGFloat) {
        self.init(frame: .zero)
        cornerString = NSAttributedString.createCenterAttributedString(string, fontSize: fontSize)
        configure()
    }
    
    private func configure() {
        numberOfLines = 0
        attributedText = cornerString
        sizeToFit()
    }
    
    
   
    
    
}
