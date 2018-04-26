//
//  UIView+JHExtension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

public extension UIView {
    ///添加阴影
    public func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = true
    }
}
