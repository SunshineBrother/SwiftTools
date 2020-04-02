//
//  main.swift
//  高级运算符
//
//  Created by yunna on 2020/1/28.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

 
var a:UInt8 = UInt8.max
//a = a + 1
a = a &+ 1
print(a)




//struct Point {
//    var x:Int, y:Int
//
//    static func + (_ p1:Point, _ p2:Point) -> Point{
//        Point(x: p1.x + p2.x, y: p1.y + p2.y)
//    }
//
//    static func - (_ p1:Point, _ p2:Point) -> Point{
//        Point(x: p1.x - p2.x, y: p1.y - p2.y)
//    }
//
//    static prefix func - (_ p:Point) -> Point{
//        Point(x: -p.x, y: -p.y)
//    }
//
//
//}


struct Person :Equatable{
    var age: Int
    static func == (_ p1:Person, _ p2:Person) ->Bool{
        p1.age == p2.age
    }
}


struct Student:Comparable {
    var age:Int
    init(age:Int) {
        self.age = age
    }
    
    static func < (_ s1:Student, _ s2:Student) -> Bool{
        s1.age < s2.age
    }

}


 

struct Point {
    var x:Int, y:Int
    
    static prefix func ++ (_ p: inout Point) -> Point{
        p = Point(x: p.x + p.x, y: p.y + p.y)
        return p
    }
}

























