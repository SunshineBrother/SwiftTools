//
//  main.swift
//  枚举
//
//  Created by yunna on 2019/10/20.
//  Copyright © 2019 yunna. All rights reserved.
//

import Foundation

//enum CompassPoint: CaseIterable {
//    case north
//    case south
//    case east
//    case west
//}
//
//for item in CompassPoint.allCases{
//    print(item)
//}
//print(CompassPoint.allCases.count)
//
//
//
//enum Date {
//    case digit(year:Int,month:Int,day:Int)
//    case dateString(String)
//}
//
//let date:Date = .digit(year: 2019, month: 10, day: 20)
//
//
//
enum Score:String {
    case perfect
    case great
    case goods
    case bad
}
print(Score.perfect.rawValue)
//
enum Season{
    case num(Int,Int,Int,Int)
    case winter
}
 
print(MemoryLayout<Season>.stride)  //40 分配占用的空间大小
print(MemoryLayout<Season>.size)    //33 实际用到的空间大小
print(MemoryLayout<Season>.alignment)//8 对其参数
 

 enum Device {
     case iPad, iPhone, AppleTV, AppleWatch
     func introduced() -> String {
         switch self {
         case .iPad: return "iPad"
         case .iPhone: return "iPhone"
         case .AppleWatch: return "AppleWatch"
         case .AppleTV: return "AppleTV"
         }
     }
 }

 print(Device.iPhone.introduced())

