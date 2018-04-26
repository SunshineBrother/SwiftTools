//
//  JHPOPAlertView.swift
//  Test
//
//  Created by yunna on 2017/12/22.
//  Copyright © 2017年 yunna. All rights reserved.
//

import UIKit
enum POPType {
    case alert
    case actionSheet
}

class JHPOPAlertView: NSObject {
 
 
    /// 弹出alert
    ///
    /// - Parameters:
    ///   - message: message
    ///   - type: type
    ///   - titleArr: 标题数组
    ///   - complete: 返回闭包
    class func POPAlertView(message:String,titleArr:[String],type:POPType,complete:@escaping ((NSInteger)->(Void))) {
        let popType = type == .alert ? UIAlertControllerStyle.alert : UIAlertControllerStyle.actionSheet
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: popType)
        
        for (index,item) in titleArr.enumerated() {
            alert.addAction(UIAlertAction.init(title: item, style: .default, handler: { (action) in
                complete(index)
                printLog(message: item)
            }))
        }
    
        if popType == UIAlertControllerStyle.actionSheet {
            alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        }
        UIApplication.shared.delegate?.window??.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}























