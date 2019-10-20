//
//  main.swift
//  函数
//
//  Created by yunna on 2019/10/19.
//  Copyright © 2019 yunna. All rights reserved.
//

import Foundation



/// 求和【概述】
/// - Parameter v1: 第一个整数
/// - Parameter v2: 第二个整数
/// - Note:传入两个整数即可【批注】
//func sum(v1:Int,v2:Int) -> Int {
//    v1+v2
//}
//
//func sum(_ v1:Int, _ v2:Int) -> Int {
//    v1 + v2
//}
//
//func sum(v1:String,v2:String) -> String {
//    v1 + v2
//}
//
//func sum(v1:Int, v2:Int, v3:Int) -> Int {
//    v1 + v2 + v3
//}
//
//
//
//
//
//func goToWork(at time:String) {
//    print("this time is \(time)")
//}
//goToWork(at: "10点")
//
//
//
//
//func check(name:String = "tom",age:Int,job:String = "none"){
//    print("name is \(name),age is \(age), job is \(job)")
//}
//
//check(age: 10)
//check(name: "kk", age: 20, job: "IT")
//check(name: "aa", age: 30)
//check(age: 25, job: "Teacher")
//
//
//
//func sum(_ numbers:Int...) -> Int{
//    var total = 0
//    for item in numbers {
//        total += item
//    }
//    return total
//}
//
//
//var b = 10
//func test(a:inout Int) {
//    a = 20
//}
//test(a: &b)
//print(b)
//
//
//
//
//func test() {
//    print("内联函数")
//}
//
//test()
//
//

//函数类型
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

var mathFunction: (Int, Int) -> Int = addTwoInts
print(mathFunction(1,2))

//函数类型可以作为函数的参数
func sum(a:Int,b:Int) -> Int {
    a + b
}
func reduction(a:Int,b:Int) -> Int {
    a - b
}

func printResult(_ mathFn:(Int,Int) -> Int, a:Int, b:Int) {
    print(mathFn(a,b))
}

printResult(sum, a: 3, b: 2)
printResult(reduction, a: 3, b: 2)


func next(_ input:Int) -> Int {
    input + 1
}

func previous(_ input:Int) -> Int {
    input - 1
}

func forward(_ forward:Bool) -> (Int) -> Int {
    forward ? next : previous
}

print(forward(true)(3))
print(forward(false)(3))



typealias Byte = Int8
typealias Short = Int16
typealias Long = Int64


typealias IntFn = (Int,Int) -> Int
func difference(v1:Int,v2:Int) -> Int {
    v1 - v2
}
let fn:IntFn = difference
print(fn(2,1))


typealias Date = (year:Int,month:Int,day:Int)
func test(_ date:Date) {
    print(date.year)
}
test((2019,10,30))






















