//
//  hhh.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/3.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

struct RuntimeKey {
    ///空数据显示内容
    static let emptyText = UnsafeRawPointer.init(bitPattern: "emptyText".hashValue)
    ///空数据的图片
    static let emptyImage = UnsafeRawPointer.init(bitPattern: "emptyImage".hashValue)
    ///垂直偏移量
    static let offset = UnsafeRawPointer.init(bitPattern: "offset".hashValue)
    ///点击回调闭包
    static var clickClosure = UnsafeRawPointer.init(bitPattern: "clickClosure".hashValue)
 
}
//MARK: -- 给UIScrollView添加属性 --
extension UIScrollView {
    ///空数据显示内容
   private var emptyText: String? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.emptyText!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, RuntimeKey.emptyText!) as? String
        }
    }
    ///空数据的图片
   private var emptyImage: String? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.emptyImage!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, RuntimeKey.emptyImage!) as? String
        }
    }
    
    ///垂直偏移量
   private var offset: CGFloat? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.offset!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, RuntimeKey.offset!) as? CGFloat
        }
    }
    
    //闭包回调
    typealias clickTipClosure = () -> Void
    // 定义一个类属性作为闭包的容器，专门存放闭包的属性
    private class BlockContainer: NSObject, NSCopying {
        func copy(with zone: NSZone? = nil) -> Any {
            return self
        }
        var clickTipClosure: clickTipClosure?
    }
    // 定义个一个计算属性
    private var newDataBlock: BlockContainer? {

        set(newValue) {
            objc_setAssociatedObject(self, RuntimeKey.clickClosure!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, RuntimeKey.clickClosure!) as? BlockContainer
        }
       
    }
  
  
}

//MARK: -- 给UIScrollView添加方法 --
extension UIScrollView :DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    
    /// 设置空白页text。image。偏移量
    ///
    /// - Parameters:
    ///   - text: text
    ///   - image: image
    ///   - offSet: 偏移量
    func addEmptyTextWithEmptyImageWithOffSet(text:String,image:String,offSet:CGFloat) {
        self.emptyText = text
        self.emptyImage = image
        self.offset = offSet
        
        self.emptyDataSetDelegate = self
        self.emptyDataSetSource = self
    }
    
    /// 设置空白页text。image
    ///
    /// - Parameters:
    ///   - text: text
    ///   - image: image
    ///
    func addEmptyTextWithEmptyImage(text:String,image:String){
        self.emptyText = text
        self.emptyImage = image
        
        
        self.emptyDataSetDelegate = self
        self.emptyDataSetSource = self
    }
    
    
    /// 仅仅设置空白页图片
    ///
    /// - image: image
    func addEmptyText(image:String){
         self.emptyImage = image
         self.emptyDataSetDelegate = self
         self.emptyDataSetSource = self
    }
    
    
    /// 仅仅设置空白页文本
    ///
    /// - Parameter text: text
    func addEmptyText(text:String){
        self.emptyText = text
        self.emptyDataSetDelegate = self
        self.emptyDataSetSource = self
    }
    
    ///点击空白页回调
    func obtainClickClosure(Closure:@escaping clickTipClosure) {
        // 创建blockContainer,将外界传来的闭包赋值给类属性中的闭包变量
        let blockContainer: BlockContainer = BlockContainer()
        blockContainer.clickTipClosure = Closure
        self.newDataBlock = blockContainer
    }
    
    
}




//MARK: - DZNEmptyDataSetSource -
extension UIScrollView {
    // 空白界面的标题
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        guard self.emptyText != nil else {
            return nil
        }
        
        let text = self.emptyText ?? ""
        let attStr = NSMutableAttributedString.init(string: text)
        attStr.addAttribute(NSAttributedStringKey.strokeColor, value: UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1), range: NSMakeRange(0, text.count))
        
        attStr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17), range: NSMakeRange(0, text.count))
        
        return attStr
    }
    // 空白页的图片
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        guard self.emptyImage != nil else {
            return nil
        }
        
        return UIImage.init(named: self.emptyImage!)
    }
    
    //是否允许滚动，默认NO
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    // 垂直偏移量
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        let set = self.offset ?? -50.0
        return CGFloat(set)
    }
    
    //点击
    public func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        self.newDataBlock?.clickTipClosure!()
    }
    
}












