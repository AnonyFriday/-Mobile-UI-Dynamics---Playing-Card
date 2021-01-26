//
//  NSAttributeString.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 26/1/21.
//

import UIKit

extension NSAttributedString {
    static func createCenterAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font                    = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font                        = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        let paragraphStyle          = NSMutableParagraphStyle()
        paragraphStyle.alignment    = .center
        
        let attributes : [NSAttributedString.Key : Any] = [
            .font : font,
            .paragraphStyle : paragraphStyle,
        ]
        
        return NSAttributedString(string: string, attributes: attributes)
    }
    

}
