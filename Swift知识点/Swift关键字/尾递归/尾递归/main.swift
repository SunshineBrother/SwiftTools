//
//  main.swift
//  尾递归
//
//  Created by yunna on 2020/4/8.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation
 
func sum(_ n:Int) -> Int {
    if n == 0 {
        return 0
    }
    return n + sum(n - 1)
}

sum(1000000)

func tailSum(_ n: Int) -> Int {
    func sumInternal(_ n: Int, current: Int) -> Int {
        if n == 0 {
            return current
        } else {
            return sumInternal(n - 1, current: current + n)
        }
    }

    return sumInternal(n, current: 0)
}

print(tailSum(1000000))














