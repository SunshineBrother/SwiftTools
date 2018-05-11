//
//  TextViewController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/10.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var TV1: JHTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TV1.placeHolder = "我是placeHolder"
        TV1.placeHolderColor = UIColor.red
        TV1.font = UIFont.systemFont(ofSize: 20)
        TV1.MaxCount = 10
        TV1.tapTwiceDisapper = true
        
    }

   
}




















