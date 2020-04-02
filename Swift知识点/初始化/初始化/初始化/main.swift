//
//  main.swift
//  初始化
//
//  Created by yunna on 2019/12/28.
//  Copyright © 2019 yunna. All rights reserved.
//

import Foundation 
//class Size {
//    var height = 0
//    var width = 0
//
//    init(height:Int,width:Int) {
//        self.height = height
//        self.width = width
//    }
//
//    convenience init(width:Int){
//        self.init(height:0, width:width)
//        self.width = width
//    }
//
//}


class Person {
    var age:Int{
        willSet{
            print("willSet",newValue)
        }
        didSet{
            print("didSet","oldValue:\(oldValue)","age:\(age)")
        }
    }
    
    init() {
        self.age = 0
    }
 
}
class Student: Person {
    override init() {
        super.init()
        self.age = 1
    }
    
    deinit {
        print("Student对象销毁")
    }
}

var stu = Student()

