
//
//  UILabel+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

struct RunTimeLabelKey {
    ///是否拥有复制功能
    static let isCopyable = UnsafeRawPointer.init(bitPattern: "isCopyable".hashValue)
}
//MARK: -- 初始化 --
extension UILabel{
  
    /// 初始化
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - color: 颜色
    ///   - fondSize: 大小
    ///   - TextAlignment: 位置
    convenience init(title:String,color:UIColor? = UIColor.black,fondSize:CGFloat?,TextAlignment:NSTextAlignment?) {
        self.init()
        self.text = title
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: fondSize ?? 17)
        
        let Alignment = TextAlignment ?? NSTextAlignment.left
        switch Alignment {
        case .left:
            self.textAlignment = NSTextAlignment.left
            break
        case .center:
            self.textAlignment = NSTextAlignment.center
            break
        case .right:
            self.textAlignment = NSTextAlignment.right
            break
        default:
            break
        }
    }
 
}

//MARK: -- 事件扩展 --
extension UILabel {
    
    var isCopyable: Bool? {
        set {
            objc_setAssociatedObject(self, RunTimeLabelKey.isCopyable!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            //添加长按手势
            self.isUserInteractionEnabled = true
            let LongPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressCopyEvent))
            self.addGestureRecognizer(LongPress)
            
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeLabelKey.isCopyable!) as? Bool
        }
    }
    
    
    
    @objc func longPressCopyEvent(){
        // 让其成为响应者
        becomeFirstResponder()
        
        // 拿出菜单控制器单例
        let menu = UIMenuController.shared
        // 创建一个复制的item
        let copy = UIMenuItem(title: "复制", action: #selector(copyText))
        // 将复制的item交给菜单控制器（菜单控制器其实可以接受多个操作）
        menu.menuItems = [copy]
        // 设置菜单控制器的点击区域为这个控件的bounds
        menu.setTargetRect(bounds, in: self)
        // 显示菜单控制器，默认是不可见状态
        menu.setMenuVisible(true, animated: true)
     
    }
    
   @objc func copyText() {
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
    
        if ((self.text) != nil) {
             UIPasteboard.general.string = self.text
        }else{
             UIPasteboard.general.string = self.attributedText?.string
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









































