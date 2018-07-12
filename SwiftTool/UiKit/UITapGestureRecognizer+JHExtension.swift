//
//  UITapGestureRecognizer+JHExtension.swift
//  RunTimeDemo-Swift
//
//  Created by yunna on 2018/4/4.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
struct RunTimeTapGestureKey {
    ///连续两次点击相差时间
    static let timeInterval = UnsafeRawPointer.init(bitPattern: "timeInterval".hashValue)
}

extension UITapGestureRecognizer:UIGestureRecognizerDelegate{
    //添加属性,在设置 timeInterval 的时候
    var timeInterval: CGFloat? {
        set {
            objc_setAssociatedObject(self, RunTimeTapGestureKey.timeInterval!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.delegate = self
        }
        get {
            
            return  objc_getAssociatedObject(self, RunTimeTapGestureKey.timeInterval!) as? CGFloat
        }
    }
    
   
    convenience init(target: Any?, action: Selector?,timeInterval:CGFloat) {
        self.init(target: target, action: action)
        self.timeInterval = timeInterval
        self.delegate = self  
    }

    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        self.isEnabled = false
        let time:TimeInterval = TimeInterval(timeInterval ?? 0.0)
        DispatchQueue.main.asyncAfter(deadline:.now() + time) {
            self.isEnabled = true
        }
        return true
    }
    
    
}























