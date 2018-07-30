//
//  countdownController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/7/27.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class countdownController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = TimerButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        btn.backgroundColor = UIColor.gray
        btn.setUP(start: "点击获取验证码", prefix: "倒计时", countTime: 10) {
            btn.isWorking = true
            print("*************")
            
        }
        self.view.addSubview(btn)
        
        
    }

    

}
