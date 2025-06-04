//
//  UIColor+Extension.swift
//  ActivityPulseBar
//
//  Created by Baptiste Sansierra on 03/06/2025.
//  Copyright © 2025 Baptiste Sansierra. All rights reserved.
//

import UIKit

extension UIColor {
    
    @objc convenience init(rgba: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var hex = rgba
        if rgba.hasPrefix("#") {
            let index = rgba.index(rgba.startIndex, offsetBy: 1)
            hex = String(rgba[index...])
        }
        let scanner = Scanner(string: hex)
        var hexValue: Int64 = 0
        guard scanner.scanHexInt64(&hexValue) else {
            print("Scan RGB hexa error, accepted formats are '#xxxxxx' or 'xxxxxx'")
            self.init(red: red, green: green, blue: blue, alpha: 1)
            return
        }
        guard hex.count == 6 else {
            print("Invalid RGB string, accepted formats are '#xxxxxx' or 'xxxxxx'", terminator: "")
            self.init(red: red, green: green, blue: blue, alpha: 1)
            return
        }
        red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        blue = CGFloat(hexValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

    class func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                return traits.userInterfaceStyle == .dark ? dark : light }
        } else {
            return light
        }
    }
    
    class func dynamicColor(light: String, dark: String) -> UIColor {
        return dynamicColor(light: UIColor(rgba: light), dark: UIColor(rgba: dark))
    }
}
