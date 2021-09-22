//
//  BaseNavigationController.swift
//  Store
//
//  Created by yunna on 2018/2/2.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    var pushing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

         
    }
 
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if pushing == true {
            return
        } else {
            pushing = true
        }
        // 当导航控制器的子视图数量大于1 的时候，隐藏tabbar
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        pushing = false
    }
}














