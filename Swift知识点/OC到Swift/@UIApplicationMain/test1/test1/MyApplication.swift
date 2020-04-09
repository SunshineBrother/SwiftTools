//
//  FLApplication.swift
//  test1
//
//  Created by yunna on 2020/4/3.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit
class MyApplication: UIApplication {
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        print("Event sent:\(event)")
    }
}
