//
//  main.swift
//  方法
//
//  Created by yunna on 2019/11/18.
//  Copyright © 2019 yunna. All rights reserved.
//

import Foundation

 
//struct Calculate {
//    var a = 0
//    var b = 0
//
//    func sum() {
//        a + b
//        self
//    }
//    static var c = 0
//    static var d = 0
//    static func reduction(){
//        self.c - self.d
//        self
//    }
//
//}


//
//struct Calculate {
//    var a = 0
//    mutating func sum(_ b:Int) {
//        a += b
//    }
//}


class Calculate {
    @discardableResult
    func sum(a:Int,b:Int) -> Int {
        a + b
    }
}
Calculate().sum(a: 1, b: 2)

