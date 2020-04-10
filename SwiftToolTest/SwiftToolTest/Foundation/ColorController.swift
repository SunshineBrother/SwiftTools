//
//  ColorController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/6/26.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class ColorController: UIViewController {
     
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        var att = NSAttributedString(string: "aaaa")
        
        att = att.bold()
        att = att.color(UIColor.red)
        
        var att1 = NSAttributedString(string: "bbbb")
        att1 = att1.strikethrough()
        
        label.attributedText = att1 + att
        
        
        
    }

    

}
