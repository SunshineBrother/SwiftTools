//
//  JHProgressHUD.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/6/27.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import MBProgressHUD
///轻触屏幕，弹出框消失
private var isTouch = false
class JHProgressHUD: NSObject {
    
    /// 提示文本
    ///
    /// - Parameters:
    ///   - text: text
    ///   - touch: 触摸加载框是否消失，false不消失
    ///   - afterDelay: 加载框显示时间
    class func ShowMessage(text:String,touch:Bool? = false,afterDelay:TimeInterval? = 1.0) {
        isTouch = touch!
        DispatchQueue.main.async {
            let window:UIWindow = UIApplication.shared.keyWindow!
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
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
    class func ShowloadingWithMessage(text:String?,touch:Bool? = false) {
        isTouch = touch!
        DispatchQueue.main.async {
            let window:UIWindow = UIApplication.shared.keyWindow!
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
            hud.backgroundView.color = UIColor.black
            hud.backgroundView.alpha = 0.2
            if text != nil {
                hud.label.text = text
            }
        }
    }
    
    /// 隐藏 加载框
    class func dismissHUD()  {
        DispatchQueue.main.async {
            let window:UIWindow = UIApplication.shared.keyWindow!
            for obj in window.subviews{
                if obj.isKind(of: MBProgressHUD.classForCoder()){
                    MBProgressHUD.hide(for: window, animated: true)
                }
                
            }
        }
        
    }
    
}

extension UIWindow{
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isTouch == true {
            isTouch = false
            JHProgressHUD.dismissHUD()
        }
        return super.hitTest(point, with: event)
    }
   
}















































