//
//  ViewController.swift
//  a
//
//  Created by 姜军辉 on 2021/9/7.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let a = ["a": "1"]
        let b = ["b": "2"]
        let c = a + b
        print(c)
        
        let d: Double = 1.23456
        print(d.format(".2"))
       
        
    }

    
}

