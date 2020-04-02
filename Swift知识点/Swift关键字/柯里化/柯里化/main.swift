//
//  main.swift
//  柯里化
//
//  Created by yunna on 2020/3/24.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

func add(_ v1:Int,_ v2:Int) -> Int {
    return v1 + v2
}
print(add(1, 2))

func add(_ v:Int) -> (Int) -> Int {
    return {$0 + v}
}
print(add(1)(2))












