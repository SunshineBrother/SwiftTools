//
//  TextFieldController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/8.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class TextFieldController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var TF1: UITextField!
    @IBOutlet weak var TF2: UITextField!
    @IBOutlet weak var TF3: UITextField!
    @IBOutlet weak var TF4: UITextField!
    @IBOutlet weak var TF5: UITextField!
    @IBOutlet weak var TF6: UITextField!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        //设置placeHolder颜色
        TF1.setPlaceHolderTextColor(UIColor.brown)
        //设置左右icon
        TF2.addLeftIcon(UIImage.init(named: "Head")!, size: CGSize(width: 25, height: 25), padding: 5)
        //右边icon
        TF2.addRightIcon(UIImage.init(named: "eyes")!, size: CGSize(width: 25, height: 25), padding: 5)
        //设备文本距离左右侧距离
        TF3.distanceSides(15, 0)
        //电话
//        TF4.MobileType = MobilePhoneType.MobileCommon
        TF4.MobileType = MobilePhoneType.MobileSpecial
        //金钱类型
        TF5.moneyType = true
        //字数限制
        TF6.maxCount = 10
        
  
    }

 
    
    
 
}






























