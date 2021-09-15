//
//  HMPopTool.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import UIKit

public class HMPopTool: NSObject {
    public enum ActionPosition {
        case top
        case center
        case bottom
        case left
        case right
    }
   
    public static let share = HMPopTool()
    /// 点击蒙版是否隐藏视图
    public var tapOutsideToDismiss = true
    /// 关闭回调
    public var closePopBlock:(() -> Void)?
    
    private override init() {}
    
    private var contentView: UIView?
    private var positionType: ActionPosition = .center
    private var actionWindow: UIWindow?
    private var startFrame: CGRect = .zero
    

    /// 弹出视图
    /// - Parameters:
    ///   - contentView: contentView
    ///   - type: type
    ///   - mask: 是否显示遮罩
    public func show(contentView: UIView, type: ActionPosition, mask: Bool = true) {
        
        self.contentView = contentView
        let screenBounds = UIScreen.main.bounds
        let width = contentView.bounds.size.width
        let height = contentView.bounds.size.height
        let animateTime: TimeInterval = 0.21
       
        let contentViewController = UIViewController()
        contentViewController.view.addSubview(contentView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(close(tap:)))
        contentViewController.view.addGestureRecognizer(tap)
        
         
        switch type {
        case .top:
            let x = (screenBounds.width - width)/2
            contentView.frame = CGRect(x: x, y: -height, width: width, height: height)
            startFrame = CGRect(x: x, y: -height, width: width, height: height)
            UIView.animate(withDuration: animateTime) {
                contentView.frame = CGRect(x: x, y: 0, width: width, height: height)
            }
            self.positionType = .top
      
        case .center:
            startFrame = CGRect(x: (screenBounds.width - width) / 2, y: (screenBounds.height - height) / 2, width: width, height: height)
            contentView.frame = CGRect(x: (screenBounds.width - width) / 2, y: (screenBounds.height - height) / 2, width: width, height: height)
            contentView.alpha = 0
            contentView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: animateTime) {
                contentView.alpha = 1
                contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }
            self.positionType = .center
      
        case .bottom:
            let x = (screenBounds.width - width)/2
            contentView.frame = CGRect(x: x, y: screenBounds.height, width: width, height: height)
            startFrame = CGRect(x: x, y: screenBounds.height, width: width, height: height)
            UIView.animate(withDuration: animateTime) {
                contentView.frame = CGRect(x: x, y: screenBounds.height - height, width: width, height: height)
            }
            self.positionType = .bottom
        case .left:
            let y = (screenBounds.height - height)/2
            contentView.frame = CGRect(x: 0 - width, y: y, width: width, height: height)
            startFrame = CGRect(x: 0 - width, y: y, width: width, height: height)
            UIView.animate(withDuration: animateTime) {
                contentView.frame = CGRect(x: 0, y: y, width: width, height: height)
            }
            self.positionType = .left
       
        case .right:
            let y = (screenBounds.height - height)/2
            contentView.frame =  CGRect(x: screenBounds.width, y: y, width: 0, height: height)
            UIView.animate(withDuration: animateTime) {
                contentView.frame = CGRect(x: screenBounds.width - width, y: y, width: width, height: height)
            }
            self.positionType = .right
        }

       
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.filter {
               $0.activationState == .foregroundActive
            }.first
            if let windowScene = windowScene as? UIWindowScene {
               self.actionWindow = UIWindow(windowScene: windowScene)
               self.actionWindow?.frame = UIScreen.main.bounds
            }
        } else {
            self.actionWindow = UIWindow(frame: screenBounds)
        }
       
        if mask == true {
           self.actionWindow?.backgroundColor = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        }
        self.actionWindow?.windowLevel = UIWindow.Level(rawValue: 4000000.0)
        self.actionWindow?.rootViewController = contentViewController
        self.actionWindow?.makeKeyAndVisible()
        
    }
    
    
    
    @objc private func close(tap: UITapGestureRecognizer) {
        guard tapOutsideToDismiss == true else {
            return
        }
        let point = tap.location(in: tap.view)
        guard let pt = contentView?.layer.convert(point, from: tap.view?.layer) else { return  }
        guard contentView?.layer.contains(pt) == false else {
            return
        }
        
        dismiss {}
    }
    
    /// 关闭弹出视图
    /// - Parameter complete: complete description
    public func dismiss(complete: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            if self.positionType == .center {
                UIView.animate(withDuration: 0.2) {
                    self.contentView?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                } completion: { _ in
                    UIView.animate(withDuration: 0.2) {
                        self.contentView?.transform = CGAffineTransform(scaleX: 0, y: 0)
                        self.contentView?.alpha = 0
                    }
                }

            } else {
                if self.contentView != nil {
                    self.contentView!.frame = self.startFrame
                }
            }
            self.actionWindow?.backgroundColor = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 0)
       }) { _ in
            self.contentView?.alpha = 1
            self.contentView = nil
            self.actionWindow?.isHidden = true
            self.actionWindow = nil
            self.startFrame = .zero
            complete()
            if self.closePopBlock != nil {
                self.closePopBlock!()
            }
       }

   }
     
}

 





