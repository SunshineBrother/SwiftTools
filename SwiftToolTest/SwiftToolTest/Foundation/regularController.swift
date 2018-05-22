//
//  regularController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class regularController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let phone = "123456789"
        let ret = PhoneNumberIsValidated(vStr: phone)
        print(ret)
    }

    

}
