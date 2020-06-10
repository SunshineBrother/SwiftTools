//
//  TimeController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class TimeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let str = getCurrentStingTime(.dateModeYMDHMS)
        print(str)
        
        
        let time = getCurrentStampTime(isMS: true)
        print(time)
        
        
    }

   

}
