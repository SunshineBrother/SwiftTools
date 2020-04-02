//
//  main.swift
//  Optional
//
//  Created by yunna on 2020/4/1.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

 
var string:String? = "string"
var anotherString:String?? = string
var literalString:String?? = "string"
var a: Optional = Optional.some(Optional.some("string"))
var b: Optional =  Optional.some(string)
var age1: Optional = .some(10)
print(anotherString)
print(literalString)
print(anotherString == literalString)



var aNil:String? = nil
var anoterNil:String?? = aNil
var literalNil:String?? = nil
print(anoterNil)
print(literalNil)
print(anoterNil == literalNil)
 



let arr = [1,2,3]
let doubled = arr.map {
    $0 * 2
}
print(doubled)

//let arr1 = [1,2,nil]
//let doubled1 = arr1.map {
//    $0 * 2
//}
//print(doubled1)
let num: Int? = nil
let result = num.map {
    $0 * 2
}

print(result)
