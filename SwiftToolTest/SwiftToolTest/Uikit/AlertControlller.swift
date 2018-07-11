//
//  AlertControlller.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/7/11.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class AlertControlller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func button1(_ sender: Any) {
        JHPOPAlertView.showSystemPOPView(message: "我是测试", titleArr: ["取消","确定"], type: .alert) { (index) -> (Void) in
            
        }
    }
    
    
    
    
    @IBAction func button2(_ sender: Any) {
        JHPOPAlertView.showSystemPOPView(message: "我是测试", titleArr: ["微信","扣扣","微博"], type: .actionSheet) { (index) -> (Void) in
            
        }
    }
    
}
