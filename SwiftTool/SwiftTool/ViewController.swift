//
//  ViewController.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/2.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        let v = CountDownView()
        
        v.frame = CGRect(x: 100, y: 100, width: 100, height: 50)

        self.view.addSubview(v)
        
      
    }

   
}

