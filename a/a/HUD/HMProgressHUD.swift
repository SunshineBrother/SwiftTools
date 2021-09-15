//
//  HMProgressHUD.swift
//  a
//
//  Created by HM on 2021/9/9.
//


import UIKit
import MBProgressHUD
class HMProgressHUD: NSObject {
    
    // toast：弹出简短message
    public static func showMessage(_ text: String) {
        guard let window: UIWindow = UIApplication.shared.keyWindow else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.detailsLabel.text = text
        hud.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = .white
        hud.backgroundView.alpha = 0.1
        hud.hide(animated: true, afterDelay: 2.0)
        hud.removeFromSuperViewOnHide = true
    }
    // 加载中
    @discardableResult
    public static func showLoading(msg: String = "加载中...") -> MBProgressHUD {
        guard let window: UIWindow = UIApplication.shared.keyWindow else {
            return MBProgressHUD()
        }
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        hud.mode = .indeterminate
        hud.label.text = msg
        hud.label.textColor = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0, alpha: 0.3)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor.white
        hud.contentColor = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
        return hud
    }
    // 加载完成
    public static func hideLoading() {
        guard let window: UIWindow = UIApplication.shared.keyWindow else {
            return
        }
        for obj in window.subviews {
            if obj.isKind(of: MBProgressHUD.classForCoder()) {
                MBProgressHUD.hide(for: window, animated: true)
            }
        }
    }
}


