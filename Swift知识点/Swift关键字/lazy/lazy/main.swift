//
//  main.swift
//  lazy
//
//  Created by yunna on 2020/3/30.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

class A {
    lazy var str:String = {
        let str = "Hello"
        print("首次访问的时候输出")
        return str
    }()
    
    lazy var str1 = "word"
}

let a = A()
print(a.str)











