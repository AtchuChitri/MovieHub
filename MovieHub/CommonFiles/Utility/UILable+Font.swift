//
//  UILable+Font.swift
//  MovieHub
//
//  Created by Atchu on 7/2/23.
//

import Foundation
import UIKit

extension UIFont {
     public static func font(withName name: FontType, size: CGFloat) -> UIFont? {
         return UIFont(name: name.rawValue, size: size)
    }
}

public enum FontType: String {
    case boldFont = "Helvetica Bold"
    case regularFont = "Helvetica"
}
