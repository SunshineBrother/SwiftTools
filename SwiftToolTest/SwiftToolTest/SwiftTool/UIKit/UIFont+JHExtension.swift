//
//  UIFont+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2020/4/10.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit
 
let KFont_10 = UIFont.systemFont(ofSize: 10)
let KFont_11 = UIFont.systemFont(ofSize: 11)
let KFont_12 = UIFont.systemFont(ofSize: 12)
let KFont_13 = UIFont.systemFont(ofSize: 13)
let KFont_14 = UIFont.systemFont(ofSize: 14)
let KFont_15 = UIFont.systemFont(ofSize: 15)
let KFont_16 = UIFont.systemFont(ofSize: 16)
let KFont_17 = UIFont.systemFont(ofSize: 17)
let KFont_18 = UIFont.systemFont(ofSize: 18)
let KFont_19 = UIFont.systemFont(ofSize: 19)
let KFont_20 = UIFont.systemFont(ofSize: 20)
let KFont_21 = UIFont.systemFont(ofSize: 21)
let KFont_22 = UIFont.systemFont(ofSize: 22)
let KFont_23 = UIFont.systemFont(ofSize: 23)
let KFont_24 = UIFont.systemFont(ofSize: 24)
let KFont_25 = UIFont.systemFont(ofSize: 25)
let KFont_26 = UIFont.systemFont(ofSize: 26)
let KFont_27 = UIFont.systemFont(ofSize: 27)
let KFont_28 = UIFont.systemFont(ofSize: 28)
let KFont_29 = UIFont.systemFont(ofSize: 29)
let KFont_30 = UIFont.systemFont(ofSize: 30)
 





let KBoldFont_10 = UIFont.boldSystemFont(ofSize: 10)
let KBoldFont_11 = UIFont.boldSystemFont(ofSize: 11)
let KBoldFont_12 = UIFont.boldSystemFont(ofSize: 12)
let KBoldFont_13 = UIFont.boldSystemFont(ofSize: 13)
let KBoldFont_14 = UIFont.boldSystemFont(ofSize: 14)
let KBoldFont_15 = UIFont.boldSystemFont(ofSize: 15)
let KBoldFont_16 = UIFont.boldSystemFont(ofSize: 16)
let KBoldFont_17 = UIFont.boldSystemFont(ofSize: 17)
let KBoldFont_18 = UIFont.boldSystemFont(ofSize: 18)
let KBoldFont_19 = UIFont.boldSystemFont(ofSize: 19)
let KBoldFont_20 = UIFont.boldSystemFont(ofSize: 20)
let KBoldFont_21 = UIFont.boldSystemFont(ofSize: 21)
let KBoldFont_22 = UIFont.boldSystemFont(ofSize: 22)
let KBoldFont_23 = UIFont.boldSystemFont(ofSize: 23)
let KBoldFont_24 = UIFont.boldSystemFont(ofSize: 24)
let KBoldFont_25 = UIFont.boldSystemFont(ofSize: 25)
let KBoldFont_26 = UIFont.boldSystemFont(ofSize: 26)
let KBoldFont_27 = UIFont.boldSystemFont(ofSize: 27)
let KBoldFont_28 = UIFont.boldSystemFont(ofSize: 28)
let KBoldFont_29 = UIFont.boldSystemFont(ofSize: 29)
let KBoldFont_30 = UIFont.boldSystemFont(ofSize: 30)


public extension UIFont {
    static func pingFangSCRegular(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    static func pingFangSCUltralight(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Ultralight", size: ofSize) ?? UIFont.pingFangSCThin(ofSize: ofSize)
    }

    static func pingFangSCLight(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Light", size: ofSize) ?? UIFont.pingFangSCRegular(ofSize: ofSize)
    }

    static func pingFangSCThin(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Thin", size: ofSize) ?? UIFont.pingFangSCLight(ofSize: ofSize)
    }

    static func pingFangSCMedium(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Medium", size: ofSize) ?? UIFont.pingFangSCRegular(ofSize: ofSize)
    }

    static func pingFangSCSemibold(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Semibold", size: ofSize) ?? UIFont.pingFangSCMedium(ofSize: ofSize)
    }

    static func pingFangSCBold(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Bold", size: ofSize) ?? UIFont.pingFangSCSemibold(ofSize: ofSize)
    }

    static func pingFangSCBoldItalic(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-BoldItalic", size: ofSize) ?? UIFont.pingFangSCBold(ofSize: ofSize)
    }
}
