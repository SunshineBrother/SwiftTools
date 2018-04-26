//
//  JHProgressHUD.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/3.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import MBProgressHUD
class JHProgressHUD: NSObject {
    
    /// 显示文本
    ///
    /// - Parameter text: text
   class func ShowMessage(text:String) {
        
        DispatchQueue.main.async {
            let window:UIWindow = UIApplication.shared.keyWindow!
            
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = text
            hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
            hud.backgroundView.color = UIColor.white
            hud.backgroundView.alpha = 0.1
            hud.hide(animated: true, afterDelay: 1.0)
            hud.removeFromSuperViewOnHide = true
            
        }
        
    }
    
  
    /// 显示带文本的 圆圈
    ///
    /// - Parameter text: text
   class func ShowloadingWithMessage(text:String?) {
        DispatchQueue.main.async {
            let window:UIWindow = UIApplication.shared.keyWindow!
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            if text != nil {
                hud.label.text = text
            }
        }
        
    }
    
    /// 隐藏 加载框
   class func dismissHUD()  {
        DispatchQueue.main.async {
            let window:UIWindow = UIApplication.shared.keyWindow!
            MBProgressHUD.hide(for: window, animated: true)
        }
    
    }
    
    
    
    
 
    
}























