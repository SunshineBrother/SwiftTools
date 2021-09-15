//
//  HMPOPAlertView.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import UIKit
// 系统弹框
enum HMSystemPOPType {
    case alert
    case actionSheet
}

class HMPopAlertView: NSObject {
    
    /// 弹出系统提示框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - titleArr: 选择数组
    ///   - type: 类型
    ///   - complete: 闭包回调
    static
    func showSystemPOPView(title: String? = "提示",
                           message: String,
                           titleArr: [String],
                           type: HMSystemPOPType,
                           complete: @escaping ((NSInteger) -> Void)) {
        
        let popType = type == .alert ? UIAlertController.Style.alert : UIAlertController.Style.actionSheet
        let alert = UIAlertController(title: title, message: message, preferredStyle: popType)
        
        for (index, item) in titleArr.enumerated() {
            alert.addAction(UIAlertAction.init(title: item, style: .default, handler: { _ in
                complete(index)
            }))
        }
        
        if popType == UIAlertController.Style.actionSheet {
            alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        }
        
        UIApplication.shared.delegate?.window??.rootViewController?.present(alert, animated: true, completion: nil)
        
        
    }

  
}


















