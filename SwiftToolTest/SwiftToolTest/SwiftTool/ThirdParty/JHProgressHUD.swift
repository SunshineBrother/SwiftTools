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
    @discardableResult
    static func ShowMessage(text:String,
                            afterDelay:TimeInterval = 2.0,
                            hudView:UIView = UIApplication.shared.keyWindow!) ->MBProgressHUD{

        let hud = MBProgressHUD.showAdded(to: hudView, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.detailsLabel.text = text
        hud.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor.white
        hud.backgroundView.alpha = 0.1
        hud.hide(animated: true, afterDelay: afterDelay)
        hud.removeFromSuperViewOnHide = true
        
        return hud
    }
    
    
    /// 加载框
    ///
    /// - Parameters:
    ///   - text: text
    ///   - touch: 触摸加载框是否消失，false不消失
    static func Showloading(text:String = "",
                            hudView:UIView = UIApplication.shared.keyWindow!) {
        
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: hudView, animated: true)
            hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
            hud.backgroundView.color = UIColor.black
            hud.backgroundView.alpha = 0.2
            hud.label.text = text
        }
    }
    
    /// 隐藏 加载框
    static func dismissHUD(hudView:UIView = UIApplication.shared.keyWindow!)  {
        DispatchQueue.main.async {
             for obj in hudView.subviews{
                 if obj.isKind(of: MBProgressHUD.classForCoder()){
                     MBProgressHUD.hide(for: hudView, animated: true)
                 }
             }
        }
        
    }
    
}

















































