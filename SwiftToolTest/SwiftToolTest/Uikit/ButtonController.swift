//
//  ButtonController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/25.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class ButtonController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置居中
        self.button1.setTitleWithImage(title: "测试", image: UIImage.init(named: "coupon")!)
        self.button1.setImageFrontTextWithCenterAlignment(imageWidth: 25, space: 10)
        
        // 设置居左
        self.button2.setTitleWithImage(title: "测试测试", image: UIImage.init(named: "coupon")!)
        self.button2.setImageFrontTextWithLeftAlignment(imageWidth: 25, space: 10, buttonWidth: button2.W)
        //上下结构
         self.button3.setTitleWithImage(title: "测试测试", image: UIImage.init(named: "coupon")!)
        self.button3.setImageFrontTextWithTopAlignment(imageWidth: 25, space: 10)
    }

  

}




























