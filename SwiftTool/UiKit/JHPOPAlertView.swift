//
//  JHPOPAlertView.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/7/10.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
 
//系统弹框
enum SystemPOPType {
    case alert
    case actionSheet
}

class JHPOPAlertView: NSObject {
    
    /// 弹出系统提示框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - titleArr: 选择数组
    ///   - type: 类型
    ///   - complete: 闭包回调
   class func showSystemPOPView(title:String? = "提示",message:String,titleArr:[String],type:SystemPOPType,complete:@escaping ((NSInteger)->(Void))) {
        let popType = type == .alert ? UIAlertControllerStyle.alert : UIAlertControllerStyle.actionSheet
        let alert = UIAlertController(title: title, message: message, preferredStyle: popType)
        
        for (index,item) in titleArr.enumerated() {
            alert.addAction(UIAlertAction.init(title: item, style: .default, handler: { (action) in
                complete(index)
                print(item)
            }))
        }
        
        if popType == UIAlertControllerStyle.actionSheet {
            alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        }
        UIApplication.shared.delegate?.window??.rootViewController?.present(alert, animated: true, completion: nil)
    }

    
   
    
 
}


















