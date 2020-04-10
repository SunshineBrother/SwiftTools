//
//  Double+JHExtension.swift
//  KVO
//
//  Created by yunna on 2020/4/8.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit

extension Double{
    func format(_ f:String) -> String {
        return String(format: "%@\(f)f", self)
    }
}
