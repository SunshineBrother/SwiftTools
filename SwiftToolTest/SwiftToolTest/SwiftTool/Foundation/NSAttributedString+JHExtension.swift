//
//  NSAttributedString+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2020/4/10.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit

public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    return ns
}
 
extension NSAttributedString{
    
    /// 加粗
    public func bold() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }
    
    
    /// 下划线
    public func underline() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue], range: range)
        return copy
    }
    
    
    /// 删除线
    public func strikethrough() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        let attributes = [
            NSAttributedStringKey.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)]
        copy.addAttributes(attributes, range: range)

        return copy
    }
    
    
    /// 前景色
    /// - Parameter color: color description
    public func color(_ color: UIColor) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedStringKey.foregroundColor: color], range: range)
        return copy
    }
    
}













