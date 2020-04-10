//
//  DictionaryController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/16.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class DictionaryController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var dic = ["1":"one","2":"two","3":"three","4":"four"]
        let dic1 = ["a":"A","2":"two"]
        let a = dic + dic1
        print(a)
       
        
        
    }

    

}
