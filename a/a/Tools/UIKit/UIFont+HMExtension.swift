//
//  UIFont+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//
 
import UIKit

public enum HMFontType: String {
    case pingfangRegular = "PingFangSC-Regular"
    case pingfangMedium = "PingFangSC-Medium"
}

extension UIFont {

    public static func type(_ type: HMFontType = .pingfangRegular, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}


