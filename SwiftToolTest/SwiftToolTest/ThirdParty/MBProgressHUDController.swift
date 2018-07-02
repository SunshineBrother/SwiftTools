//
//  MBProgressHUDController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/6/29.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class MBProgressHUDController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    @IBAction func Test1(_ sender: Any) {
        
        JHProgressHUD.ShowMessage(text: "我是测试HUD", touch: true, afterDelay: 5)
        
        
    }
    
    
    @IBAction func Test2(_ sender: Any) {
        JHProgressHUD.ShowMessage(text: "我是测试HUD", touch: false, afterDelay: 5)
    }
    
    
    @IBAction func Test3(_ sender: Any) {
        JHProgressHUD.ShowloadingWithMessage(text: "我是测试HUD", touch: true)
    }
    
    
    
    @IBAction func Test4(_ sender: Any) {
        JHProgressHUD.ShowloadingWithMessage(text: "我是测试HUD")
    }
    

}

















