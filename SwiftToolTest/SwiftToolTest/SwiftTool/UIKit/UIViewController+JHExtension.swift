//
//  UIViewController+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2020/4/10.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit
 
//MARK: -- 通知 --
extension UIViewController{
    ///添加通知
    public func addNotificationObserver(_ name: String, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    ///移除某一个通知
    public func removeNotificationObserver(_ name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    ///移除所有通知
    public func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
   
}

//MARK: -- 弹出一个选择框 --
extension UIViewController{
    @discardableResult
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
             
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
}

//MARK:-- 添加计算属性 --
struct RunTimeViewControllerKey {
    static let callBackClose = UnsafeRawPointer.init(bitPattern: "callBackClose".hashValue)
}
extension UIViewController{
    typealias myClose = ((_ result:Any) -> ())
    ///一般回调
    var callBackClose:((_ result:Any) -> ())?{
        set {
            objc_setAssociatedObject(self, RunTimeViewControllerKey.callBackClose!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, RunTimeViewControllerKey.callBackClose!) as? myClose
        }
    }
}




















