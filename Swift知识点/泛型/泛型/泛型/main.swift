//
//  main.swift
//  泛型
//
//  Created by yunna on 2020/1/28.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation
 
func swapValues(_ a: inout Int,_ b: inout Int) {
    (a,b) = (b,a)
}

func swapValues(_ a: inout Double,_ b: inout Double) {
    (a,b) = (b,a)
}

func swapValues(_ a: inout String,_ b: inout String) {
    (a,b) = (b,a)
}


func swapValues<T>(_ a: inout T,_ b: inout T) {
    (a,b) = (b,a)
}
var a = 10
var b = 11
swap(&a, &b)
var c = "123"
var d = "456"
swap(&c, &d)


protocol Stackable {
    associatedtype Element //关联类型
    associatedtype Element1 //关联类型
    mutating func push(_ element:Element)
    mutating func pop() -> Element
    func top() ->  Element
}



protocol Runnable {}
class Person {}
func swapValue<T:Person & Runnable>(_ a:inout T,_ b: inout T)  {
    (a,b) = (b,a)
}


var age:Int? = 10
var age1:Optional<Int> = Optional<Int>.some(10)
var age2:Optional = .some(10)
age2 = nil
age2 = .none


func test(_ age:Int?) {
    switch age {
    case let v?:
        print(v)
    case nil:
        print("none")
    }
}


