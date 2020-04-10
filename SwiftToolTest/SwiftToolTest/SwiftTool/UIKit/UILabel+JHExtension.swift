//
//  Extension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/4.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
struct RunTimeLabelKey {
    //复制文本信息
    static let copyMsg = UnsafeRawPointer.init(bitPattern: "copyMsg".hashValue)
    
}
extension UILabel {
    
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

 
//MARK: -- 事件扩展 --
extension UILabel {
    var copyMsg: String? {
        set {
            objc_setAssociatedObject(self, RunTimeLabelKey.copyMsg!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            //添加长按手势
            self.isUserInteractionEnabled = true
            let LongPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressCopyEvent))
            self.addGestureRecognizer(LongPress)

        }
        get {
            return  objc_getAssociatedObject(self, RunTimeLabelKey.copyMsg!) as? String
        }
    }
    
    
    @objc func longPressCopyEvent(){
        // 让其成为响应者
        becomeFirstResponder()
        
        // 拿出菜单控制器单例
        let menu = UIMenuController.shared
        // 创建一个复制的item
        let copy = UIMenuItem(title: "copy", action: #selector(copyText))
        // 将复制的item交给菜单控制器（菜单控制器其实可以接受多个操作）
        menu.menuItems = [copy]
        // 设置菜单控制器的点击区域为这个控件的bounds
        menu.setTargetRect(bounds, in: self)
        // 显示菜单控制器，默认是不可见状态
        menu.setMenuVisible(true, animated: true)
        
    }
    
    @objc func copyText() {
        if copyMsg != nil {
            UIPasteboard.general.string = copyMsg
        }
       
    }
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(copyText) {
            return true
        } else {
            return false
        }
    }
    
    /// 拥有成为响应者的能力
    open override var canBecomeFirstResponder: Bool{
        return true
    }
    
}











