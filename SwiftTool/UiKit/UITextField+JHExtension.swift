//
//  UITextField+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/8.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
//手机号类型
enum MobilePhoneType: String {
    case MobileCommon = "MobileCommon"
    case MobileSpecial = "MobileSpecial"
}
struct RunTimeTextFieldKey {
    ///最大数量
    static let maxCount = UnsafeRawPointer.init(bitPattern: "maxCount".hashValue)
    ///金钱类型
    static let moneyType = UnsafeRawPointer.init(bitPattern: "moneyType".hashValue)
    ///手机号类型 普通的12345678901   344格式 123 4567 8901
    static let MobileType = UnsafeRawPointer.init(bitPattern: "MobileType".hashValue)
    
}

//MARK:-- 属性实现 --
extension UITextField{
    //开始输入的监听
    @objc func textFieldStartChange(){
        //是否是金额
        let MonType = self.moneyType ?? false
        if MonType == true {
            self.keyboardType = UIKeyboardType.decimalPad
        }
        
        if self.MobileType != nil {
            self.keyboardType = UIKeyboardType.phonePad
        }
    }
    ///文本变化时的监听
    @objc func textFieldDidChange(){
         //最大数量限制
        let count = self.maxCount ?? 0
        if count > 0 {
            setMAXCountNumber()
        }
        //是否是金额
        let MonType = self.moneyType ?? false
        if MonType  == true {
            limitMoneyType()
        }
        
        //手机号
        if self.MobileType != nil {
            limitMobileType()
        }
     
    }
    
    //最大数量限制
    func setMAXCountNumber() {
        let TFText = self.text ?? ""
        let count = TFText.count
        if count > self.maxCount!  {
            self.text = stringByReplacing(textString: TFText, index: self.maxCount!, length: count-self.maxCount!, replacText: "")
        }
     
    }
    //金钱类型
    /*
     1.要求用户输入首位不能为小数点;
     2.小数点后不超过两位，小数点无法输入超过一个;
     3.如果首位为0，后面仅能输入小数点
     */
    func limitMoneyType() {
        var TFText = self.text ?? ""
        //第一位是.
        if TFText.hasPrefix("."){
            TFText = stringByReplacing(textString: TFText, index: 0, length: 1, replacText: "0.")
        }
        //第一位是0 那么后面是只能输入.
        if (TFText.hasPrefix("0") && TFText.count > 1) {
             TFText = stringByReplacing(textString: TFText, index: 1, length: 1, replacText: ".")
        }
        
        let regular = "^[0-9]*((\\.|,)[0-9]{0,2})?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regular)
        let ret = predicate.evaluate(with: TFText)
        if ret == false {
             TFText.remove(at: TFText.index(before: TFText.endIndex))
        }
        
        self.text = TFText
    }
    
    //手机号,第一个是1 总11位
    func limitMobileType()  {
        
        var TFText = self.text ?? ""
        let count = TFText.count
        if (TFText.hasPrefix("1") == false) && (TFText.count > 0){
            TFText = stringByReplacing(textString: TFText, index: 0, length: 1, replacText: "1.")
        }
        
        if self.MobileType == MobilePhoneType.MobileCommon {
            if TFText.count > 11 {
                TFText = stringByReplacing(textString: TFText, index: 11, length: count-11, replacText: "")
            }
        }else if self.MobileType == MobilePhoneType.MobileSpecial {
            if TFText.count == 3 || TFText.count == 8{
                TFText = TFText + " "
            }
            if TFText.count > 13 {
                TFText = stringByReplacing(textString: TFText, index: 13, length: count-13, replacText: "")
            }
        }
        
        
        self.text = TFText
  
    }
    
    
    
    //字符串的替换
    func stringByReplacing(textString:String,index:Int,length:Int,replacText:String) -> String {
        var TEXT = textString
        let startIndex = textString.index(textString.startIndex, offsetBy: index)
        TEXT.replaceSubrange(startIndex..<TEXT.index(startIndex, offsetBy: length), with: replacText)
    
        return TEXT
    }
    
    
}

//MARK:-- UI扩展 --
extension UITextField{
    
    ///设置placehold颜色
   func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }
    
    /// 文本距离左右侧的距离
    ///
    /// - Parameters:
    ///   - leftWidth: 左侧距离
    ///   - rightWidth: 右侧距离
    func distanceSides(_ leftWidth:CGFloat,_ rightWidth:CGFloat? = 0)  {
        //左侧view
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftWidth, height: 5))
        leftViewMode = UITextFieldViewMode.always
        
        //右侧view
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: rightWidth!, height: 5))
        rightViewMode = UITextFieldViewMode.always
    }
    
    /// 添加标题
    ///
    /// - Parameters:
    ///   - titleLabel: titleLabel
    ///   - titleWidth: titleWidth
    ///   - padding: 距离右侧输入框的距离
    func addLeftTile(titleLabel:UILabel,titleWidth:CGFloat,padding: CGFloat)  {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: titleWidth + padding + CGFloat(5), height: 30))
        titleLabel.frame = CGRect(x: 5, y: 0, width: titleWidth, height: 30)
        leftView?.addSubview(titleLabel)
        self.leftViewMode = UITextFieldViewMode.always
        
    }
    
    /// 添加左侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: icon的size
    ///   - padding: 距离文本距离
    func addLeftIcon(_ image: UIImage,size:CGSize,padding: CGFloat)  {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: size.width+2*padding-3, height: size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: size.width, height: size.height)
        self.leftView?.addSubview(imageView)
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    /// 添加右侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: size
    ///   - padding: padding
    func addRightIcon(_ image: UIImage,size:CGSize,padding: CGFloat)  {
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: size.width+2*padding, height: size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: size.width, height: size.height)
        self.rightView?.addSubview(imageView)
        rightViewMode = UITextFieldViewMode.always
       
    }
 
}






//MARK:-- 属性扩展 --
extension UITextField{
    //最大数量
    var maxCount: Int? {
        set {
            objc_setAssociatedObject(self, RunTimeTextFieldKey.maxCount!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            //添加监听
            self.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeTextFieldKey.maxCount!) as? Int
        }
    }
    
    //金钱类型
    var moneyType: Bool? {
        set {
            objc_setAssociatedObject(self, RunTimeTextFieldKey.moneyType!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            //添加监听
            self.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
            self.addTarget(self, action: #selector(textFieldStartChange), for: UIControlEvents.editingDidBegin)
            
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeTextFieldKey.moneyType!) as? Bool
        }
    }
    
    
    
    //手机号类型
    var MobileType: MobilePhoneType? {
        set {
            objc_setAssociatedObject(self, RunTimeTextFieldKey.MobileType!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            //添加监听
            self.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
          self.addTarget(self, action: #selector(textFieldStartChange), for: UIControlEvents.editingDidBegin)
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeTextFieldKey.MobileType!) as? MobilePhoneType
        }
    }
    
    
}






























