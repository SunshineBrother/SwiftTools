//
//  main.swift
//  属性观察器
//
//  Created by yunna on 2020/3/30.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

class Person {
    var age:Int = 0{
        willSet{
            print("即将将年龄从\(age)设置为\(newValue)")
        }
        didSet{
            print("已经将年龄从\(oldValue)设置为\(age)")
        }
    }
}

let p = Person()
p.age = 10



class A {
    var number:Int {
        get{
            print("get 1")
            return 1
        }
        set{
            print("set \(newValue)")
        }
    }
}

class B:A {
    override var number: Int{
        willSet{
            print("willSet")
        }
        didSet{
            print("didSet")
        }
    }
}

let b = B()
b.number = 10





