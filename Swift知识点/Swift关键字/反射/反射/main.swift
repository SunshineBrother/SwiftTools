//
//  main.swift
//  反射
//
//  Created by yunna on 2020/3/30.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

struct Person {
    let name:String
    let age:Int
}

let xiaoming = Person(name: "小明", age: 10)
let r = Mirror(reflecting: xiaoming)

print("xiaoming是\(r.displayStyle)")
print("属性个数：\(r.children.count)")

for child in r.children{
    print("属性名:\(child.label) 值：\(child.value)")
}

print("-------")
print(dump(xiaoming))




func valueFrom(_ object: Any, key: String) -> Any? {
    let mirror = Mirror(reflecting: object)
    for child in mirror.children {
        let (targetKey, targetMirror) = (child.label, child.value)
        if key == targetKey {
            return targetMirror
        }
    }
    return nil
}


if let name = valueFrom(xiaoming, key: "name") as? String {
    print("通过 key 得到值: \(name)")
}


