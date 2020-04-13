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

        let myBtn = MyCountDownButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        myBtn.setTitle("获取验证码", for: .normal)
        myBtn.setTitle("正在获取验证码：second秒", for: .disabled)
        myBtn.setTitleColor(.black, for: .normal)
        myBtn.maxSecond = 30 // 默认为60
        myBtn.countdown = true
        myBtn.backgroundColor = RGB(r: 200, g: 200, b: 200)
        self.view.addSubview(myBtn)
        myBtn.addTapGesture { (_) in
            myBtn.countdown = true
        }
        
        
    }

    

}
