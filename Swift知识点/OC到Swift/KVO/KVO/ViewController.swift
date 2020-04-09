//
//  ViewController.swift
//  KVO
//
//  Created by yunna on 2020/4/8.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         
        let obj = Class()
    }

}




class MyClass: NSObject {
    @objc dynamic var date = Date()
}

private var myContext = 0
class Class: NSObject {

    var myObject: MyClass!

    override init() {
        super.init()
        myObject = MyClass()
        print("初始化 MyClass，当前日期: \(myObject.date)")
        myObject.addObserver(self,
            forKeyPath: "date",
            options: .new,
            context: &myContext)

        delay(3) {
            self.myObject.date = Date()
        }
    }

    override func observeValue(forKeyPath keyPath: String?,
                            of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                              context: UnsafeMutableRawPointer?)
    {
        if let change = change, context == &myContext {
            if let newDate = change[.newKey] as? Date {
                print("MyClass 日期发生变化 \(newDate)")
            }
        }
    }
}
 
let obj = Class()




class AnotherClass: NSObject {
    var myObject: MyClass!
    var observation: NSKeyValueObservation?
    override init() {
        super.init()
        myObject = MyClass()
        print("初始化 AnotherClass，当前日期: \(myObject.date)")

        observation = myObject.observe(\MyClass.date, options: [.new]) { (_, change) in
            if let newDate = change.newValue {
                print("AnotherClass 日期发生变化 \(newDate)")
            }
        }

        delay(1) { self.myObject.date = Date() }
    }
}




































