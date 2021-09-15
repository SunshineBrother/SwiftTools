//
//  UITapGestureRecognizer+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import UIKit
 
struct RunTimeTapGestureKey {
    // 连续两次点击相差时间
    static let timeInterval = UnsafeRawPointer.init(bitPattern: "timeInterval".hashValue)
}

extension UITapGestureRecognizer: UIGestureRecognizerDelegate {
    // 添加属性,在设置 timeInterval 的时候
    var timeInterval: CGFloat? {
        get {
            return  objc_getAssociatedObject(self, RunTimeTapGestureKey.timeInterval!) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, RunTimeTapGestureKey.timeInterval!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.delegate = self
        }
        
    }
    
    
    /// 有时间间隔的点击事件
    /// - Parameters:
    ///   - target: target description
    ///   - action: action description
    ///   - timeInterval: timeInterval description
    convenience init(target: Any?,
                     action: Selector?,
                     timeInterval: CGFloat) {
        self.init(target: target, action: action)
        self.timeInterval = timeInterval
        self.delegate = self
    }

    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        self.isEnabled = false
        let time: TimeInterval = TimeInterval(timeInterval ?? 0.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.isEnabled = true
        }
        return true
    }
   
}























