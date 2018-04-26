//
//  JHExtension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/8.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

extension UITextField{
    /// 设定文本距离左侧的距离
    func leftWidth(_ leftWidth: CGFloat){
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftWidth, height: 5))
        leftViewMode = UITextFieldViewMode.always
        
    }
 
    
    ///添加左侧icon
    public func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        self.leftView = imageView
        self.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    ///设置placehold颜色
    public func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }
    
    
}



















