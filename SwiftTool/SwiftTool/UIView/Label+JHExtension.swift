//
//  Extension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/4.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
extension UILabel {
    
    
    /// 遍历构造函数 label
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - color: 颜色
    ///   - backColor: 背景色
    ///   - fondSize: fondSize
 
    convenience init(title:String,color:UIColor,backColor:UIColor?,fondSize:CGFloat?) {
        self.init()
        self.text = title
        self.textColor = color
        
        if backColor != nil {
            self.backgroundColor = backColor!
        }
        if fondSize != nil {
            self.font = UIFont.systemFont(ofSize: fondSize!)
        }
        
    }
    
    
    /// 改变字间距
    ///
    /// - Parameter space: space
    func changeWordSpace(space:Float) {
        let labelText = self.text
        let attStr = NSMutableAttributedString.init(string: labelText!)
        attStr.addAttribute(NSAttributedStringKey.kern, value: (space), range: NSMakeRange(0, (labelText?.count)!))
        attStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: NSMutableParagraphStyle.init(), range: NSMakeRange(0, (labelText?.count)!))
        self.attributedText = attStr
        self.sizeToFit()
    }
    
    
    
    /// 改变行间距
    ///
    /// - Parameter space: space
    func changeLineSpace(space:Float) {
        let labelText = self.text
        let attStr = NSMutableAttributedString.init(string: labelText!)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = CGFloat(space)
        attStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, (labelText?.count)!))
        self.attributedText = attStr
        self.sizeToFit()
    }
    
    
    /// 改变行间距和字间距
    ///
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - wordSpace: 字间距
    func changeLineSpaceWithWordSpace(lineSpace:Float,wordSpace:Float) {
        let labelText = self.text
        let attStr = NSMutableAttributedString.init(string: labelText!)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = CGFloat(lineSpace)
        attStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, (labelText?.count)!))
        attStr.addAttribute(NSAttributedStringKey.kern, value: (wordSpace), range: NSMakeRange(0, (labelText?.count)!))
        self.attributedText = attStr
        self.sizeToFit()
    }
    
    
    
    
    
}















