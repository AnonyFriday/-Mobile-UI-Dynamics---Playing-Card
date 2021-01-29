//
//  UIImage.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 28/1/21.
//

import UIKit

enum ImageFromXCAssets {
    static let cardBackImage    = UIImage(named: "cardback")!
    static var cardFaceUpCardImage : ((String) -> UIImage?) = { imageName in
        if let image = UIImage(named: imageName) {
            return image
        }
        return nil
    }
}
