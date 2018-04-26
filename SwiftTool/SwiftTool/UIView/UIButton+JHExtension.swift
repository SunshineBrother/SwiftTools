//
//  Extension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/4.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// button的便利构造函数
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: 大小
    ///   - color: 文字颜色
    ///   - backColor: 背景色
    convenience init(title:String,fontSize:CGFloat?,color:UIColor?,backColor:UIColor?) {
        self.init()
        setTitle(title, for: .normal)
        if fontSize != nil {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
        
        if color != nil {
            setTitleColor(color, for: .normal)
        }
        
        if backColor != nil {
            self.backgroundColor = backColor
        }
        
    }
   
}

























