//
//  UIView+HARMAYExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//



import UIKit
 
// MARK: - 添加计算属性 --
struct RunTimeViewKey {
    static let RunTimeViewName = UnsafeRawPointer.init(bitPattern: "RunTimeViewName".hashValue)
    static let RunTimeViewParam = UnsafeRawPointer.init(bitPattern: "RunTimeViewParam".hashValue)
    static let RunTimeViewArray = UnsafeRawPointer.init(bitPattern: "RunTimeViewArray".hashValue)
    static let RunTimeViewAny = UnsafeRawPointer.init(bitPattern: "RunTimeViewAny".hashValue)
}

extension UIView {
    var name: String? {
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewName!) as? String
        }
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewName!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
        
    }
    
    var viewParam: [String: Any]? {
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewParam!) as? Dictionary
        }
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewParam!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
        
    }
    
    var viewArray: [Any]? {
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewArray!) as? [Any]
        }
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewArray!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
        
    }
    
    var viewAny: Any? {
        get {
            return  objc_getAssociatedObject(self, RunTimeViewKey.RunTimeViewAny!)
        }
        set {
            objc_setAssociatedObject(self, RunTimeViewKey.RunTimeViewAny!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
    }
    
}



// MARK: - 添加方法
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
    /// 获取视图的控制器
    func getSuperController() -> UIViewController {
        var next = superview
        while next != nil {
            let nextResponder = next?.next
            if nextResponder is UIViewController {
                return (nextResponder as? UIViewController) ?? UIViewController()
            }
            next = next?.superview
        }
         
        return UIViewController()
    }
    
    
}


extension UIView {
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat, rect: CGRect = CGRect.zero) {
        guard corners != .allCorners else {
            layer.cornerRadius = radii
            layer.masksToBounds = true
            return
        }
        let frame = rect == .zero ? bounds : rect
        let maskPath = UIBezierPath(roundedRect: frame, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    /// 设置边框的颜色和宽度
    func setBorder(_ color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    /// 设置边框&圆角
    func setViewBorderRadius(radius: CGFloat, color: UIColor, width: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    

    /// 设置阴影（需要圆角则不能使用masksToBounds）。
    func setShadow(_ shadowRadius: CGFloat = 3, color: UIColor = UIColor.black, radius: CGFloat = 5, shadowOpacity: Float = 0.5) {
        self.layer.cornerRadius = radius
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
    }

     
}





// MARK: - 点击方法 --
extension UIView {
    /// 点击事件
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, methods: String) {
        let action = Selector(methods)
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
        tapAction?(tap)
    }
}


