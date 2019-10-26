//
//  main.swift
//  汇编分析枚举
//
//  Created by yunna on 2019/10/26.
//  Copyright © 2019 yunna. All rights reserved.
//

import Foundation

/*
enum TestEnum :Int{
    case test1 = 1000
    case test2
    case test3
    case test4
    case test5
}

print(MemoryLayout<TestEnum>.stride)    //1
print(MemoryLayout<TestEnum>.size)      //1
print(MemoryLayout<TestEnum>.alignment) //1

var a = TestEnum.test1    //00
print(Mems.ptr(ofVal: &a))
a = .test2                 //01
a = .test3                 //02
a = .test4                 //03
a = .test5                 //04

print("-----------")
*/
 
 
enum TestEnum {
    case test1(Int,Int,Int)
    case test2(Int,Int)
    case test3(Int)
    case test4(Bool)
    case test5
}


print(MemoryLayout<TestEnum>.stride)    //32
print(MemoryLayout<TestEnum>.size)      //25
print(MemoryLayout<TestEnum>.alignment) //8

/*
 64 00 00 00 00 00 00 00
 01 00 00 00 00 00 00 00
 02 00 00 00 00 00 00 00
 00
 00 00 00 00 00 00 00
 */
var a = TestEnum.test1(100,2,3)
print(Mems.ptr(ofVal: &a))

/*
 64 00 00 00 00 00 00 00
 01 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00
 01
 00 00 00 00 00 00 00 00 00
 */
a = .test2(100, 1)

/*
 64 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00
 02
 00 00 00 00 00 00 00
 */
a = .test3(100)


print("-----------")
 













