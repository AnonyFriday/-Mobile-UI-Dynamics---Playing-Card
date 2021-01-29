//
//  UIImage.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 28/1/21.
//

import UIKit

enum ImageFromXCAssets {
    static let cardBackImage    = UIImage(named: "cardback", in:Bundle(for: KDPlayingCardView.self.classForCoder()), compatibleWith: UITraitCollection())!
    static var cardFaceUpCardImage : ((String) -> UIImage?) = { imageName in
        if let image = UIImage(named: imageName, in: Bundle(for: KDPlayingCardView.self.classForCoder()), compatibleWith: UITraitCollection()) {
            return image
        }
        return nil
    }
}
