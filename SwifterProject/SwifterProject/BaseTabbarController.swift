//
//  AppDelegate.swift
//  SwifterProject
//
//  Created by jiangjunhui on 2021/9/23.
//

import UIKit
import BeeHive

class BaseTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        if let order: OrderServerProtocol = BeeHive.shareInstance().createService(OrderServerProtocol.self) as? OrderServerProtocol {
//            let orderVC = BaseNavigationController(rootViewController: order.getOrderController())
//            setupChildVC(childVC: orderVC, title: "order", normalImage: "manager_selected", selectedImage: "manager_selected")
//        }
//        
//        
//        if let home: HomeServerProtocol = BeeHive.shareInstance().createService(HomeServerProtocol.self) as? HomeServerProtocol {
//            let homeVC = BaseNavigationController(rootViewController: home.getHomeController())
//            setupChildVC(childVC: homeVC, title: "home", normalImage: "manager_selected", selectedImage: "manager_selected")
//        }
 
        
        
        
        
        
        
       
      
    }
    

    func setupChildVC(childVC: UIViewController,
                      title: String,
                      normalImage: String,
                      selectedImage: String) {
        
        childVC.tabBarItem.title = title
        // tabbar正常状态下的图片
        childVC.tabBarItem.image = UIImage(named: normalImage)
        // tabbar选中状态下的图片
        let select = UIImage(named: selectedImage)
        childVC.tabBarItem.selectedImage = select?.withRenderingMode(.alwaysOriginal)
        self.addChild(childVC)
         
    }

}