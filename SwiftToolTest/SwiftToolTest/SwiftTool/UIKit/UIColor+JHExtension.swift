//
//  Color+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/6/26.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

///RGBA
func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) ->UIColor{
    return UIColor(red: r/225.0, green: g/225.0, blue: b/225.0, alpha: a)
}
///RGB
func RGB(r:CGFloat,g:CGFloat,b:CGFloat) ->UIColor{
    return UIColor(red: r/225.0, green: g/225.0, blue: b/225.0, alpha: 1.0)
}
///随机色
func randomColor() ->  UIColor{
    let r = Int(arc4random_uniform(255))
    let g = Int(arc4random_uniform(255))
    let b = Int(arc4random_uniform(255))
    return RGB(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
}

extension UIColor{
    ///随机色
    public static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = arc4random()%255
        let randomGreen = arc4random()%255
        let randomBlue = arc4random()%255
        let alpha = randomAlpha ? arc4random()%255 : 1
        return RGBA(CGFloat(randomRed), CGFloat(randomGreen), CGFloat(randomBlue), CGFloat(alpha))
    }

    /// rgba
    public static func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    /// rgb
    public static func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return RGBA(r, g, b, 1.0)
    }
    ///UIColor转化为16进制
    public var hex: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8
        rgb = rgb | (Int)(blue * 255) << 0
        
        return String(format: "#%06x", rgb)
    }
    ///16进制转rgb
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)        } else {
            return nil
        }
    }
    
}
























