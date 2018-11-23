//
//  LabelController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//Copyright © 2018年 yunna. All rights reserved.

import UIKit

class LabelController: UIViewController {
    let text = "这个label具有复制 改变字间距 行间距 和 让文本居左上的功能"
    
    
    @IBOutlet weak var TextView: UITextView!
    
    @IBOutlet weak var Label: JHLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
 
        Label.WordSpace = 10
        Label.text = text
        Label.numberOfLines = 0
        Label.isCopyable = true
     
    }

    
    @IBAction func ButtonEvent(_ sender: Any) {
        Label.topText = true
        Label.text = "我要左上啦我要左上啦我要左上啦我要左上啦我要左上啦我要左上啦我要左上啦我要左上啦我要左上啦我要左上啦我要左上啦"
    }
    
}






























