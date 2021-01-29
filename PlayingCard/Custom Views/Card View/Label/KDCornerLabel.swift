//
//  KDLabel.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 26/1/21.
//

import UIKit

class KDCornerLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(attributedString: NSAttributedString?) {
        self.init(frame: .zero)
        attributedText = attributedString
        configure()
    }
    
    private func configure() {
        numberOfLines = 0
        sizeToFit()
        adjustsFontForContentSizeCategory = true
    }
    
    
    //MARK: Reset to adapt the change of font size accessibility
    func resetToFitFontSizeDynamically() {
        frame.size = .zero
        sizeToFit()
    }
    
    
   
    
    
}
