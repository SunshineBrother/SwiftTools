//
//  main.swift
//  属性
//
//  Created by yunna on 2019/11/16.
//  Copyright © 2019 yunna. All rights reserved.
//

import Foundation



//struct Circle {
//    var radius:Double
//    var diameter:Double{
//        get{
//            radius * 2
//        }
//    }
//}
//
//var c = Circle(radius: 10)
//print(c.diameter)
//c.radius = 5
//print(c.diameter)

//enum TestEnum:Int {
//    case test1 = 1, test2 = 2, test3 = 3
//    var rawValue:Int{
//        switch self {
//        case .test1:
//            return 10
//        case .test2:
//            return 20
//        case .test3:
//            return 30
//        }
//    }
//}
//print(TestEnum.test1.rawValue)
 


//class PhotoView {
//    lazy var image:UIImage = {
//        let url = "xxx.png"
//        let data = Data(url)
//        return UIImage(data:data)
//    }
//}


//
//struct Point {
//    var x = 0
//    var y = 0
//    lazy var z = 0
//}
//
//let p1 = Point()
//print(p1.z)
//var p2 = Point()
//print(p2.z)



//struct Circle {
//    var radius:Double{
//        willSet{
//            print("willSet",newValue)
//        }
//        didSet{
//            print("didSet",oldValue)
//        }
//    }
//
//}


//struct Shape {
//    var width:Int
//    var side:Int {
//        willSet{
//            print("willSet",newValue)
//        }
//        didSet{
//            print("didSet",oldValue)
//        }
//    }
//
//    var grith:Int{
//        set{
//            width = newValue / side
//            print("setGrith",newValue)
//        }
//        get{
//            print("getGrith")
//            return width * side
//        }
//    }
//
//    func show() {
//        print("width:\(width)--side:\(side)--grith:\(grith)")
//    }
//
//}
//
//
//func test (_ num: inout Int){
//    print("test1")
//    num = 20
//}
//
//var s = Shape(width: 10, side: 4)
//test(&s.side)
////s.show()
//print("-------")

struct Test {
     static var num = 11
}
var num1 = Test.num
 








