//
//  main.swift
//  闭包
//
//  Created by yunna on 2019/11/2.
//  Copyright © 2019 yunna. All rights reserved.
//

import Foundation


/*
 
//函数
func sum(_ v1:Int,_ v2:Int) -> Int {
    v1 + v2
}
//闭包表达式
var fn = {
    (v1:Int,v2:Int) in
    return v1 + v2
}
 
print(sum(1, 2))
print(fn(1,2))

*/



/*
 
 //闭包表达式的简写
 let names = ["Chris","Alex","Ewa","Barry","Daniella"]
 //1
 func backward(_ s1: String, _ s2: String) -> Bool {
     return s1 > s2
 }
 var reversedNames = names.sorted(by: backward)
 print(reversedNames)

 //2
 reversedNames = names.sorted(by: {(s1:String,s2:String) -> Bool in
     return s1 > s2
 })

 //3
 reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )


 //4
 reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

 //5
 reversedNames = names.sorted(by: { $0 > $1 } )

 //6
 reversedNames = names.sorted(by: >)

 */


/*
 
 func exec(v1:Int,v2:Int,fn:(Int,Int) -> Int) {
     print(fn(v1,v2))
 }
  
 //调用
 exec(v1: 10, v2: 20){
     $0 + $1
 }
 
 */



/*
 
 func exec(fn:(Int,Int) -> Int) {
     print(fn(1,2))
 }

 exec(fn: {$0 + $1})
 exec(){$0 + $1}
 exec{$0 + $1}
 
 */

 
//捕获值
/*
 typealias Fn = (Int) -> Int
 func getFn() -> Fn {

     var num = 0
     func plus (_ i:Int) -> Int{
         num += i
         return num
     }
     return plus
 }

 var fn = getFn()
 print(fn(1))
 print(fn(2))
 print(fn(3))
 print(fn(4))

 //print(fn(1),fn(2),fn(3),fn(4))



 class Closure {
     var num = 0
     func plus (_ i:Int) -> Int{
         num += i
         return num
     }
    
 }
  
 var cs = Closure()
 cs.plus(1)
 cs.plus(2)
 cs.plus(3)
 cs.plus(4)
 */


/*
 
 typealias Fn = (Int) -> (Int,Int)
 func getFn() -> (Fn,Fn) {

     var num1 = 0
     var num2 = 0
     
     func plus (_ i:Int) -> (Int,Int){
         num1 += i
         num2 += i * 2
         return (num1,num2)
     }
     
     func minus (_ i:Int) -> (Int,Int){
         num1 -= i
         num2 -= i * 2
         return (num1,num2)
     }
     
     return (plus,minus)
 }

 let (p,m) = getFn()
 print(p(5))
 print(m(4))
 print(p(3))
 print(m(2))



 class Closure {
     var num1 = 0
     var num2 = 0
     
     func plus (_ i:Int) -> (Int,Int){
         num1 += i
         num2 += i * 2
         return (num1,num2)
     }
     
     func minus (_ i:Int) -> (Int,Int){
         num1 -= i
         num2 -= i * 2
         return (num1,num2)
     }
 }

 var cs = Closure()
 print(cs.plus(5))
 print(cs.minus(4))
 print(cs.plus(3))
 print(cs.minus(2))

 
 */



 
/*
 var functions:[() -> Int] = []
 for i in 1...3{
     functions.append{i}
 }

 for f in functions {
     print(f())
 }

 class Closure {
     var i:Int
     init(_ i:Int) {
         self.i = i
     }
     
     func get() -> Int {
         return i
     }
 }

 var cs:[Closure] = []
 for i in 1...3{
     cs.append(Closure(i))
 }

 for cls in cs{
     print(cls.get())
 }
 */


 
func getFirstPositive1(_ v1:Int, _ v2:Int) -> Int {
    return v1 > 0 ? v1 : v2
}
getFirstPositive1(1, 2)


func getFirstPositive2(_ v1:Int, _ v2:() -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive2(1, 2)
getFirstPositive2(1, {2})

func getFirstPositive3(_ v1:Int, _ v2:@autoclosure () -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive3(1, 2)
