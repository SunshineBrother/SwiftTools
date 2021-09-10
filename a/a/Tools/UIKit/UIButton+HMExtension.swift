//
//  UIButton+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import UIKit
extension UIButton {
    // 枚举图片的位置
    enum ButtonImageEdgeInsetsStyle: Int {
        case top       // 上图下文字
        case left      // 左图右文字
        case bottom    // 下图上文字
        case right     // 右图左文字
    }

   

    // MARK: 设置图片文字方向距离
    func layoutButtonImageEdgeInsetsStyle(style: ButtonImageEdgeInsetsStyle,
                                          space: CGFloat) {
//        let imageWidth: CGFloat = (self.imageView?.frame.size.width)!
//        let imageHeight: CGFloat = (self.imageView?.frame.size.height)!
//
//        var labelWidth: CGFloat = 0
//        var labelHeight: CGFloat = 0
//
//        labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
//        labelHeight = (self.titleLabel?.intrinsicContentSize.height)!

        guard let imageWidth = self.imageView?.frame.size.width,
              let imageHeight = self.imageView?.frame.size.height,
              let labelWidth = self.titleLabel?.intrinsicContentSize.width,
              let labelHeight = self.titleLabel?.intrinsicContentSize.height else {
            return
        }
        
        
        
        var imageEdgeInsets: UIEdgeInsets = .zero
        var labelEdgeInsets: UIEdgeInsets = .zero

        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space / 2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-space / 2.0, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space / 2.0, bottom: 0, right: space / 2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space / 2.0, bottom: 0, right: -space / 2.0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space / 2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - space / 2.0, left: -imageWidth, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space / 2.0, bottom: 0, right: -labelWidth - space / 2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space / 2.0, bottom: 0, right: imageWidth+space / 2.0)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
