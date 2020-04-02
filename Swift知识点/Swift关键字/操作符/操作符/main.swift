//
//  main.swift
//  操作符
//
//  Created by yunna on 2020/3/25.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

struct Vector2D {
    var x:CGFloat = 0
    var y:CGFloat = 0
}

let v1 = Vector2D(x: 2.0, y: 3.0)
let v2 = Vector2D(x: 1.0, y: 4.0)

func +(left:Vector2D,right:Vector2D) -> Vector2D {
    Vector2D(x: left.x + right.x, y: left.y + right.y)
}
let v3 = v1 + v2

 

/// 定义优先级组
precedencegroup MyPrecedence {
    // higherThan: AdditionPrecedence   // 优先级,比加法运算高
    lowerThan: AdditionPrecedence       // 优先级, 比加法运算低
    associativity: none                 // 结合方向:left, right or none
    assignment: false                   // true=赋值运算符,false=非赋值运算符
}

infix operator +++: MyPrecedence        // 继承 MyPrecedence 优先级组
// infix operator +++: AdditionPrecedence // 也可以直接继承加法优先级组(AdditionPrecedence)或其他优先级组
func +++(left: Int, right: Int) -> Int {
    return left+right*2
}
 
print(2+++3) // 8

prefix operator ==+
prefix func ==+(left: Int) -> Int {
    
    return left*2
}
print(==+2) // 4



postfix operator +==
postfix func +==(right: Int) -> Int {
    
    return right*3
}
print(2+==) // 6


