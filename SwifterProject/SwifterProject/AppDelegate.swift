//
//  AppDelegate.swift
//  SwifterProject
//
//  Created by jiangjunhui on 2021/9/23.
//

import UIKit
import BeeHive

@UIApplicationMain
class AppDelegate: BHAppDelegate {

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        BHContext.shareInstance().application = application
//        BHContext.shareInstance().launchOptions = launchOptions
//        BHContext.shareInstance().moduleConfigName = "Module"
//        BHContext.shareInstance().serviceConfigName = "Service"
//
//        BeeHive.shareInstance().enableException = true
//        BeeHive.shareInstance().context = BHContext.shareInstance()
//
        
        super.application(application, didFinishLaunchingWithOptions: launchOptions)
      
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        let root = BaseTabbarController()
        window?.rootViewController = root
        self.window?.makeKeyAndVisible()
        
        return true
    }

    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        
        return true
    }
}

