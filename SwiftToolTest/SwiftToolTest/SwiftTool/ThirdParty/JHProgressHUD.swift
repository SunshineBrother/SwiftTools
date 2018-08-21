//
//  JHProgressHUD.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/6/27.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import MBProgressHUD

class JHProgressHUD: NSObject {
    
    /// 提示文本
    ///
    /// - Parameters:
    ///   - text: text
    ///   - afterDelay: 加载框显示时间
    class func ShowMessage(text:String,afterDelay:TimeInterval? = 1.0,superView:UIView? = nil) {

        DispatchQueue.main.async {
            var hudSuperView:UIView
            if superView == nil{
                let window = UIApplication.shared.keyWindow!
                hudSuperView = window
            }else{
                hudSuperView = superView!
            }
            
            let hud = MBProgressHUD.showAdded(to: hudSuperView, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = text
            hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
            hud.backgroundView.color = UIColor.black
            hud.backgroundView.alpha = 0.2
            hud.hide(animated: true, afterDelay: afterDelay!)
            hud.removeFromSuperViewOnHide = true
        }
    }
    
    
    /// 加载框
    ///
    /// - Parameters:
    ///   - text: text
    ///   - touch: 触摸加载框是否消失，false不消失
    class func Showloading(text:String?,superView:UIView? = nil) {
        
        DispatchQueue.main.async {
            var hudSuperView:UIView
            if superView == nil{
                let window = UIApplication.shared.keyWindow!
                hudSuperView = window
            }else{
                hudSuperView = superView!
            }
            let hud = MBProgressHUD.showAdded(to: hudSuperView, animated: true)
            hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
            hud.backgroundView.color = UIColor.black
            hud.backgroundView.alpha = 0.2
            if text != nil {
                hud.label.text = text
            }
        }
    }
    
    /// 隐藏 加载框
    class func dismissHUD(superView:UIView? = nil)  {
        DispatchQueue.main.async {
            if superView == nil{
                let window:UIWindow = UIApplication.shared.keyWindow!
                for obj in window.subviews{
                    if obj.isKind(of: MBProgressHUD.classForCoder()){
                        MBProgressHUD.hide(for: window, animated: true)
                    }
                    
                }
            }else{
                for obj in (superView?.subviews)!{
                    if obj.isKind(of: MBProgressHUD.classForCoder()){
                        MBProgressHUD.hide(for: superView!, animated: true)
                    }
                }
            }
            
        }
        
    }
    
}

















































