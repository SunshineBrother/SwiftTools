//
//  main.swift
//  autoclosure
//
//  Created by yunna on 2020/3/25.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

func getFirstPositive1(_ v1:Int, _ v2:Int) -> Int {
    return v1 > 0 ? v1 : v2
}
getFirstPositive1(1, 2)


func getFirstPositive2(_ v1:Int, _ v2:() -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive2(1, 2) //这个报错
getFirstPositive2(1, {2})

func getFirstPositive3(_ v1:Int, _ v2:@autoclosure () -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive3(1, 2)


