
//
//  UIButton+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/25.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
//MARK: -- 常见set方法 --
extension UIButton{
    
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, target: AnyObject, action: Selector) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        addTarget(target, action: action, for:.touchUpInside)
    }
    
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, target: AnyObject, action: Selector,timeInterval:CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        self.timeInterval = timeInterval
        addTarget(target, action: action, for:.touchUpInside)
    }
    
    
    /// 设置选中状态文字颜色
    ///
    /// - Parameters:
    ///   - normolColor: normolColor
    ///   - selectColor: selectColor
    func setTitleColor(normolColor:UIColor,selectColor:UIColor)  {
        self.setTitleColor(normolColor, for: UIControlState.normal)
        self.setTitleColor(selectColor, for: UIControlState.selected)
    }
    
    /// 设置选择状态和未选中状态的image
    ///
    /// - Parameters:
    ///   - normolImge: normolImge
    ///   - selectImage: selectImage
    func setImage(normolImge:UIImage,selectImage:UIImage)  {
        self.setImage(normolImge, for: UIControlState.normal)
        self.setImage(selectImage, for: UIControlState.selected)
    }
    
    /// 设置未选择状态的title和color
    ///
    /// - Parameters:
    ///   - title: title
    ///   - titleColor: color
    func setTitleWithTitleColor(title:String,titleColor:UIColor)  {
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(titleColor, for: UIControlState.normal)
    }
    
    /// 设置title&image
    ///
    /// - Parameters:
    ///   - title: title
    ///   - image: image
    func setTitleWithImage(title:String,image:UIImage) {
        setImage(image, for: .normal)
        setTitle(title, for: .normal)
    }

}

//MARK: -- runtime添加属性 --
struct RunTimeButtonKey {
    ///连续两次点击相差时间
    static let timeInterval = UnsafeRawPointer.init(bitPattern: "timeInterval".hashValue)
  
}

extension UIButton {
    
    //添加属性,在设置 timeInterval 的时候 修改button的执行事件
    var timeInterval: CGFloat? {
        set {
            objc_setAssociatedObject(self, RunTimeButtonKey.timeInterval!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            UIButton.changeFunction
        }
        
        get {
            
            return  objc_getAssociatedObject(self, RunTimeButtonKey.timeInterval!) as? CGFloat
        }
        
    }
    
    private static let changeFunction: () = {
        //交换方法
        let systemMethod = class_getInstanceMethod(UIButton.classForCoder(), #selector(UIButton.sendAction(_:to:for:)))
        let swizzMethod = class_getInstanceMethod(UIButton.classForCoder(), #selector(UIButton.mySendAction(_:to:for:)))
        method_exchangeImplementations(systemMethod!, swizzMethod!)
        
    }()
    
    @objc private dynamic func mySendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        self.isUserInteractionEnabled = false
        let time:TimeInterval = TimeInterval(timeInterval ?? 0.0)
        DispatchQueue.main.asyncAfter(deadline:.now() + time) {
            self.isUserInteractionEnabled = true
        }
        mySendAction(action, to: target, for: event)
    }
 
}


//MARK: -- 界面布局 --
extension UIButton {
    
    /// 整体在中间 image在左 title在右
    ///
    /// - Parameters:
    ///   - imageWidth: imageWidth
    ///   - space: image和Button的间距
    func setImageFrontTextWithCenterAlignment(imageWidth:CGFloat, space:CGFloat)  {
        let image = UIImage.scaleTo(image: self.imageView!.image!, w: imageWidth, h: imageWidth)
        setImage(image, for: .normal)
        
        let insetAmount = space / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        
    }
    
   
    /// 整体在最左侧   image在左 title在右
    ///
    /// - Parameters:
    ///   - imageWidth: imageWidth
    ///   - space: space
    ///   - buttonWidth: buttonWidth
    func setImageFrontTextWithLeftAlignment(imageWidth:CGFloat, space:CGFloat,buttonWidth : CGFloat)  {
        let image = UIImage.scaleTo(image: self.imageView!.image!, w: imageWidth, h: imageWidth)
        setImage(image, for: .normal)
        
        //布局界面
        let titleLabelWidth = self.titleLabel?.text?.getWidth(font: (self.titleLabel?.font)!) ?? 0
        //左右两边的空隙
        let spaceW = (buttonWidth - titleLabelWidth - imageWidth)/2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -spaceW+space, bottom: 0, right: spaceW-space)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -spaceW+2*space, bottom: 0, right: spaceW-space)
        
    }
    
    
    
    /// 上下结构 image在上 label在下
    ///
    /// - Parameters:
    ///   - imageWidth: imageWidth
    ///   - space: space
    func setImageFrontTextWithTopAlignment(imageWidth:CGFloat, space:CGFloat)  {
        let image = UIImage.scaleTo(image: self.imageView!.image!, w: imageWidth, h: imageWidth)
        setImage(image, for: .normal)
        
        //布局界面
        let titleLabelWidth = self.titleLabel?.text?.getWidth(font: (self.titleLabel?.font)!) ?? 0
        let labelHeight = CGFloat((self.titleLabel?.font.pointSize)!)

        imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2, left: 0, bottom: 0, right: -titleLabelWidth)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageWidth-space/2, right: 0)
    }
    
    
    
    
}








































