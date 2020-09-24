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
    static let RunTimeViewName = UnsafeRawPointer.init(bitPattern: "RunTimeViewName".hashValue)
    static let RunTimeViewParam = UnsafeRawPointer.init(bitPattern: "RunTimeViewParam".hashValue)
    static let RunTimeViewArray = UnsafeRawPointer.init(bitPattern: "RunTimeViewArray".hashValue)
    static let RunTimeViewAny = UnsafeRawPointer.init(bitPattern: "RunTimeViewAny".hashValue)
}

extension UIView {
    var name: String? {
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewName!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewName!) as? String
        }
    }
    
    var ViewParam: Dictionary<String, Any>? {
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewParam!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewParam!) as? Dictionary
        }
    }
    
    var viewArray: [Any]? {
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewArray!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewArray!) as? [Any]
        }
    }
    
    var viewAny: Any? {
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewAny!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewAny!)
        }
    }
    
}


//MARK: -- 设置边框和切圆角 --
extension UIView {
    /// 添加阴影
    /// - Parameters:
    ///   - theColor: 阴影
    ///   - offSet: 偏移量
    ///   - opacity: 透明度
    func addShadow(theColor:UIColor = .gray,offSet:CGSize = CGSize(width: 0, height: 2),opacity:Float = 1) {
        self.layer.shadowColor = theColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
    }
    
    /// 切圆
    /*
      参考
     cutCorner(size: 10, roundingCorners: [.bottomRight,.bottomLeft,.topRight,.topLeft])
     */
    func cutCorner(size:CGFloat,
                   roundingCorners:UIRectCorner = [.bottomRight,.bottomLeft,.topRight,.topLeft]) {
        let cornerRadii = CGSize(width: size, height: size)
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.name = "JH_CutCorner"
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    

    /// 设置边框
    public func addBorder(size: CGFloat, color: UIColor) {
        let names = ["JH_BorderTop",
                     "JH_BorderBottom",
                     "JH_BorderLeft",
                     "JH_BorderRight"]
        removeLayer(by: names)
        addBorderTop(size: size, color: color)
        addBorderBottom(size: size, color: color)
        addBorderLeft(size: size, color: color)
        addBorderRight(size: size, color: color)
    }
    ///设置顶部边框
    public func addBorderTop(size: CGFloat, color: UIColor) {
        removeLayer(by: ["JH_BorderTop"])
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color, name: "JH_BorderTop")
    }
    /// 设置底部边框
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        removeLayer(by: ["JH_BorderBottom"])
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color, name: "JH_BorderBottom")
    }
    /// 设置左侧边框
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        removeLayer(by: ["JH_BorderLeft"])
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color, name: "JH_BorderLeft")
    }
    /// 设置右侧边框
    public func addBorderRight(size: CGFloat, color: UIColor) {
        removeLayer(by: ["JH_BorderRight"])
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color, name: "JH_BorderRight")
    }
    
    fileprivate
    func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor,name:String) {
        let border = CALayer()
        border.name = name
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    
    /// 移除layer 根据名称
    /// - Parameter name: name
    func removeLayer(by names:[String]) {
        if self.layer.sublayers != nil {
            for item in self.layer.sublayers! {
                let name = item.name ?? ""
                if names.contains(name) {
                    item.removeFromSuperlayer()
                }
            }
        }
    }
    
    
}

//MARK:-- 添加方法 --
extension UIView {
    /// 移除所有子视图
    public func removeAllChildView() {
        subviews.forEach { $0.removeFromSuperview() }
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
extension UIView{
    
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }

   
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }

  
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }

    
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }

    
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }

    
    public var right: CGFloat {
        get {
            return self.x + self.w
        } set(value) {
            self.x = value - self.w
        }
    }

     
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }

     
    public var bottom: CGFloat {
        get {
            return self.y + self.h
        } set(value) {
            self.y = value - self.h
        }
    }

     
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }

     
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }

     
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }

     
    public var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }
 
}










