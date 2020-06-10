//
//  UIView+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
 
//MARK:-- 添加计算属性 --
struct RunTimeViewKey {
    static let RunTimeViewID = UnsafeRawPointer.init(bitPattern: "RunTimeViewID".hashValue)
    static let RunTimeViewParam = UnsafeRawPointer.init(bitPattern: "RunTimeViewParam".hashValue)
}

extension UIView {
    /// viewId
    var ViewID: String? {
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewID!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewID!) as? String
        }
    }
    
    ///ViewParam
    var ViewParam: Dictionary<String, Any>? {
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewParam!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewParam!) as? Dictionary
        }
    }
 
}

//MARK:-- 添加方法 --
extension UIView {
    /// 移除所有子视图
    public func removeAllChildView() {
        _ = self.subviews.map {
            $0.removeFromSuperview()
        }
    }
    
    
    /// 切半圆 一边是直角 一边切圆角
    /// - Parameters: 左边是直角，右边是圆角
    ///   - roundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight
    ///   - cornerRadii: self.height/2,self.height/2
    func cutSemicircle(roundingCorners:UIRectCorner,cornerRadii:CGSize) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    /// 设置圆角
    public func addCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    /// 设置边框
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    ///设置顶部边框
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    /// 设置底部边框
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    /// 设置左侧边框
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    /// 设置右侧边框
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    
    /// view截图为image
    public func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    ///获取视图的控制器
    func getSuperController() -> UIViewController {
        var next = superview
        while (next != nil) {
            let nextResponder = next?.next
            if (nextResponder is UIViewController) {
                return (nextResponder as? UIViewController) ?? UIViewController()
            }
            next = next?.superview
        }
         
        return UIViewController()
    }
}

// MARK: -- 点击方法 --
extension UIView{
    ///点击事件
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    public func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}



class BlockTap: UITapGestureRecognizer {
    private var tapAction: ((UITapGestureRecognizer) -> Void)?

    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    public convenience init (
        tapCount: Int = 1,
        fingerCount: Int = 1,
        action: ((UITapGestureRecognizer) -> Void)?) {
            self.init()
            self.numberOfTapsRequired = tapCount
            #if os(iOS)
            self.numberOfTouchesRequired = fingerCount
            #endif

            self.tapAction = action
            self.addTarget(self, action: #selector(BlockTap.didTap(_:)))
    }

    @objc open func didTap (_ tap: UITapGestureRecognizer) {
        tapAction? (tap)
    }
}


//MARK:-- 添加存储属性 --
extension UIView {
    /// 宽
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    /// 高
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }
    /// X
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    /// Y
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    ///centerX
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    ///centerY
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    
}

















