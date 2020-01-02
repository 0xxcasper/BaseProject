//
//  FontsApp.swift
//  TMD
//
//  Created by iMac Flix on Jun/24/2019.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

import UIKit

enum FontsApp: String {
    case regular = "Roboto-Regular"
    case medium = "Roboto-Medium"
    case light = "Roboto-Light"
    case bold = "Roboto-Bold"
    case italic = "Roboto-Italic"
    case lightItalic = "Roboto-LightItalic"
    case mediumItalic = "Roboto-MediumItalic"
    case sfProTextHeavy = "SFProText-Heavy"
    case sfProTextMedium = "SFProText-Medium"
    case courierBold = "courier-bold"
    
    func sizeFont(withSize size: FontSize) -> UIFont {
        return UIFont(name: self.rawValue, size: CGFloat(size.rawValue)) ?? UIFont.systemFont(ofSize: CGFloat(size.rawValue))
    }
}

enum FontSize: Int {
    case h7 = 7
    case h8 = 8
    case h9 = 9
    case h10 = 10
    case h11 = 11
    case h12 = 12
    case h13 = 13
    case h14 = 14
    case h15 = 15
    case h16 = 16
    case h17 = 17
    case h18 = 18
    case h20 = 20
    case h22 = 22
    case h24 = 24
    case h26 = 26
    case h28 = 28
    case h30 = 30
    case h40 = 40
    case h50 = 50
}
