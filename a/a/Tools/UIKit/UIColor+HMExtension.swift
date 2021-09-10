//
//  UIColor+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import UIKit

extension UIColor {
    /// 随机颜色
    public class var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
    
    /// 16进制颜色
    public convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0xFF00) >> 8) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 适配暗黑色调
    /// - Parameters:
    ///   - withLightColor: withLightColor description
    ///   - darkColor: darkColor description
    /// - Returns: UIColor
    public static func color(_ lightColor: UIColor, _ darkColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init(dynamicProvider: { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .light {
                    return lightColor
                } else {
                    return darkColor
                }
            })
        } else {
            return lightColor
        }
    }
}
