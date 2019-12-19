//
//  main.swift
//  下标
//
//  Created by yunna on 2019/12/19.
//  Copyright © 2019 yunna. All rights reserved.
//

import Foundation

 
class Point {
    var x = 0.0, y = 0.0
    subscript(index:Int) -> Double{
        set{
            if index == 0{
                x = newValue
            }else if index == 1{
                y = newValue
            }
        }
        get{
            if index == 0{
                return x
            }else if index == 1{
                return y
            }
            return 0
        }
    }
}
 

var p = Point()
p[0] = 11.1
p[1] = 22.2
print(p.x)   //11.1
print(p.y)   //22.2
print(p[0])  //11.1
print(p[1])  //22.2




class Person {
    var name = "tom"
    var age = 0
    subscript(age:Int,name:String) -> Person{
        let p = Person()
        p.age = age
        p.name = name
        return p
    }
}


