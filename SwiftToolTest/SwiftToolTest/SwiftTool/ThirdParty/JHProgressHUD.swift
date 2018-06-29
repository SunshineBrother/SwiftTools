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
            
            let hud = MBProgressHUD.showAdded(to: JHHUDView.sharedInstance, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = text
            hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
            hud.backgroundView.color = UIColor.white
            hud.backgroundView.alpha = 0.1
            hud.hide(animated: true, afterDelay: afterDelay!)
            hud.removeFromSuperViewOnHide = true
            
        }
    }
    
    
    /// 加载框
    ///
    /// - Parameters:
    ///   - text: text
    ///   - touch: 触摸加载框是否消失，false不消失
    ///   - afterDelay: 加载框显示时间
    class func ShowloadingWithMessage(text:String?,touch:Bool? = false,afterDelay:TimeInterval? = 1.0) {
        DispatchQueue.main.async {
            
            let hud = MBProgressHUD.showAdded(to: JHHUDView.sharedInstance, animated: true)
            if text != nil {
                hud.label.text = text
            }
        }
    }
    
    /// 隐藏 加载框
    class func dismissHUD()  {
        DispatchQueue.main.async {
            for obj in JHHUDView.sharedInstance.subviews{
                if obj.isKind(of: MBProgressHUD.classForCoder()){
                    MBProgressHUD.hide(for: JHHUDView.sharedInstance, animated: true)
                }
                
            }
        }
        
    }
    
    
}

private class JHHUDView: UIView {
    
    static var sharedInstance : JHHUDView {
        struct Static {
            static let instance : JHHUDView = JHHUDView()
            
        }
        let MyWindow:UIWindow = UIApplication.shared.keyWindow!
        Static.instance.frame = MyWindow.frame
        MyWindow.addSubview(Static.instance)
        return Static.instance
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTouch == true {
            JHProgressHUD.dismissHUD()
        }
    }
}

















































