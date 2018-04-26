//
//  Extension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/4.
//  Copyright © 2018年 yunna. All rights reserved.
//

import Foundation

extension String {
   
    /// 获取指定位置和大小的字符串
    public func subStringFrom(index: Int,length:Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
 
    
    /// 将字符串通过特定的字符串拆分为字符串数组
    ///
    /// - Parameter string: 拆分数组使用的字符串
    /// - Returns: 字符串数组
    func split(string:String) -> [String] {
        return NSString(string: self).components(separatedBy: string)
    }
  
    
    /// 获取文本高度
    ///
    /// - Parameters:
    ///   - font: font
    ///   - fixedWidth: fixedWidth
    func obtainTextHeight(font : UIFont = UIFont.systemFont(ofSize: 18), fixedWidth : CGFloat) -> CGFloat {
        
        guard self.count > 0 && fixedWidth > 0 else {
            return 0
        }
        
        let size = CGSize(width:fixedWidth, height:CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context:nil)
        
        return rect.size.height
    }
    
    
    /// 获取文本宽度
    ///
    /// - Parameter font: font
    func obtainTextWidth(font : UIFont = UIFont.systemFont(ofSize: 17)) -> CGFloat {
        
        guard self.count > 0 else {
            return 0
        }
        
        let size = CGSize(width:CGFloat.greatestFiniteMagnitude, height:0)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context:nil)
        
        return rect.size.width
    }
    
    

    
}










