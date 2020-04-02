//
//  main.swift
//  实例化方法动态调用
//
//  Created by yunna on 2020/4/2.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation
 

 
class MyClass {
    func method(number: Int) -> Int {
        return number + 1
    }
}

let cls = MyClass()
cls.method(number: 1)



let f = MyClass.method
let object = MyClass()
let result = f(object)(1)
 
let f1 = { (obj: MyClass) in obj.method } 


























