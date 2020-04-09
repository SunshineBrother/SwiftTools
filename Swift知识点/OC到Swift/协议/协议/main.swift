//
//  main.swift
//  协议
//
//  Created by yunna on 2020/4/3.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

 
protocol MyProtocol {
    func mustProtocolMethod() //必须实现方法
    func mustProtocolMethod1() //必须实现方法
}


class MyClass: MyProtocol {
    func mustProtocolMethod() {
        print("MyClass-->必须实现方法：mustProtocolMethod")
    }
    
    func mustProtocolMethod1() {
        print("MyClass-->必须实现方法：mustProtocolMethod1")
    }
    
}

let cls = MyClass()
cls.mustProtocolMethod()
cls.mustProtocolMethod1()





@objc protocol MyProtocol1 {
    @objc optional func optionalProtocolMethod() //可选方法
    func mustProtocolMethod1() //必须实现方法
}


class MyClass1: MyProtocol1 {
    func mustProtocolMethod1() {
         print("MyClass1-->必须实现方法：protocolMethod1")
    }
}

let cls1 = MyClass1()
cls1.mustProtocolMethod1()



protocol MyProtocol2 {
    func optionalProtocolMethod1() //可选方法
    func optionalProtocolMethod2() //可选方法
    func mustProtocolMethod1() //必须实现方法
}

extension MyProtocol2{
    func optionalProtocolMethod1(){
        
    }
    
    func optionalProtocolMethod2(){
        
    }
}






