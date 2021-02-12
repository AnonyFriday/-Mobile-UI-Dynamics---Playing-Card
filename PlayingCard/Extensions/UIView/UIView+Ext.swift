//
//  UIView+Ext.swift
//  PlayingCard
//
//  Created by Vu Kim Duy on 26/1/21.
//

import UIKit

extension UIView {
    func addSubViews(views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}


