//
//  main.swift
//  自省
//
//  Created by yunna on 2020/4/8.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation
 

class ClassA: NSObject {}
class ClassB: ClassA {}

let obj1 = ClassA()
let obj2 = ClassB()

print(obj1.isKind(of: ClassA.self))
print(obj2.isMember(of: ClassA.self))











