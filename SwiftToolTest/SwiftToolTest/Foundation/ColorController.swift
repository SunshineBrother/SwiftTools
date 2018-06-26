//
//  ColorController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/6/26.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class ColorController: UIViewController {
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//         bgView.backgroundColor = UIColor.init(hexString: "#CC00FF")
        
//        bgView.backgroundColor = UIColor.RGB(100, 100, 100)
        bgView.backgroundColor = UIColor.random()
        
    }

    

}
