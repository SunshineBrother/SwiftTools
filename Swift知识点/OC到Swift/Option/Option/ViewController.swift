//
//  ViewController.swift
//  Option
//
//  Created by yunna on 2020/4/8.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit
struct YourOption: OptionSet {
    let rawValue: UInt
    static let none = YourOption(rawValue: 0)
    static let option1 = YourOption(rawValue: 1)
    static let option2 = YourOption(rawValue: 1 << 1)
    //...
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         
        
        
        
    }
 

}

