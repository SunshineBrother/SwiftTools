//
//  UITextField+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import UIKit
 
struct RunTimeTextFieldKey {
    /// 最大数量
    static let maxCount = UnsafeRawPointer.init(bitPattern: "maxCount".hashValue)
}

extension UITextField {
    /// 最大数量
    var maxCount: Int? {
        get {
            return  objc_getAssociatedObject(self, RunTimeTextFieldKey.maxCount!) as? Int
        }
        set {
            objc_setAssociatedObject(self, RunTimeTextFieldKey.maxCount!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            // 添加监听
            self.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        }
        
    }
}

extension UITextField {
     
    // 文本变化时的监听
    @objc func textFieldDidChange() {
        if (self.maxCount ?? 0) > 0 {
            setMAXCountNumber()
        }
    }
    
    // 最大数量限制
    func setMAXCountNumber() {
        let stringText = self.text ?? ""
        let count = stringText.count
        let max = self.maxCount ?? 0
        guard count > max else {
            return
        }
        self.text = stringByReplacing(textString: stringText, index: max, length: count-max, replacText: "")
     
    }
     
    // 字符串的替换
    func stringByReplacing(textString: String,
                           index: Int,
                           length: Int,
                           replacText: String) -> String {
        var TEXT = textString
        let startIndex = textString.index(textString.startIndex, offsetBy: index)
        TEXT.replaceSubrange(startIndex..<TEXT.index(startIndex, offsetBy: length), with: replacText)
    
        return TEXT
    }
    
    
}
