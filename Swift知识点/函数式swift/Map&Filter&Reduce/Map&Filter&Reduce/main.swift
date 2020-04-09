//
//  main.swift
//  Map&Filter&Reduce
//
//  Created by yunna on 2020/4/9.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

func incrementArray(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x + 1)
    }
    return result
}

func incrementArray1(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x * 2)
    }
    return result
}


func incrementArray2(xs: [String]) -> [String] {
    var result: [String] = []
    for x in xs {
        result.append(x + ",")
    }
    return result
}


func compute<T>(array:[T],transform:(T) -> T) -> [T] {
    var result:[T] = []
    for x in array {
        result.append(transform(x))
    }
    return result
}

print(compute(array: [1,2,3], transform: {$0 * 2}))

func double2(array:[Int]) -> [Int] {
    return compute(array: array, transform: {$0 * 2})
}


extension Array{
    /// 数组转换，对数字的每一个元素进行转换，然后返回新的数组
    /// - Parameter transform:转换类型
    func map<T>(transform:(Element) -> T) -> [T] {
        var result:[T] = []
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}


let arr = [1,2,3]
print(arr.map({$0 * 3}))



let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]

func getSwiftFiles(files: [String]) -> [String] {
    var result: [String] = []
    for file in files {
        if file.hasSuffix(".swift") {
            result.append(file)
        }
    }
    return result
}

print(getSwiftFiles(files: exampleFiles))


extension Array{
    func filter(includeElement:(Element) -> Bool) -> [Element] {
        var result:[Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        return result
    }
}

print(exampleFiles.filter(includeElement: {$0.hasSuffix(".swift")}))

 

func sum(xs: [Int]) -> Int {
    var result: Int = 0
    for x in xs {
        result += x
    }
    return result
}

func product(xs: [Int]) -> Int {
    var result: Int = 1
    for x in xs {
        result = x * result
    }
    return result
}

func concatenate(xs: [String]) -> String {
    var result: String = ""
    for x in xs {
        result += x
    }
    return result
}


extension Array {
    func reduce<T>(initial: T, combine: (T, Element) -> T) -> T {
        var result = initial
        for x in self {
            result = combine(result, x)
        }
        return result
    }
}
