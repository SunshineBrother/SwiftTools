//
//  main.swift
//  值类型和引用类型
//
//  Created by yunna on 2020/4/3.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation
 
struct CoordinateStruct {
    var x: Double
    var y: Double
}

var coordA = CoordinateStruct(x: 0, y: 0)
var coordB = coordA

coordA.x = 100.0
print("coordA.x -> \(coordA.x)")
print("coordB.x -> \(coordB.x)")

withUnsafePointer(to: &coordA) { print("\($0)") }
withUnsafePointer(to: &coordB) { print("\($0)") }


class Dog {
    var height = 0.0
    var weight = 0.0
}

var dogA = Dog()
var dogB = dogA

dogA.height = 50.0
print(Unmanaged.passUnretained(dogA).toOpaque())
print(Unmanaged.passUnretained(dogB).toOpaque())













