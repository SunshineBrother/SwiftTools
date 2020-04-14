//
//  Array+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/15.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

extension Array where Element : Equatable {
  
    /// 删除  重复元素
    public func removedDuplicates() -> [Element] {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }

    ///移除对象
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {
             remove(at: index)
        }
     }
     
    /// 获取指定区间内的字符串
    /// - Parameter range: 区间
    public func get(at range: ClosedRange<Int>) -> Array {
        let halfOpenClampedRange = Range(range).clamped(to: Range(indices))
        return Array(self[halfOpenClampedRange])
    }
    
    ///传入下标数组，获取该下标数组对应的数组值
    subscript(input: [Int]) -> ArraySlice<Element> {
           get {
               var result = ArraySlice<Element>()
               for i in input {
                   assert(i < self.count, "Index out of range")
                   result.append(self[i])
               }
               return result
           }
           set {
               for (index,i) in input.enumerated() {
                   assert(i < self.count, "Index out of range")
                   self[i] = newValue[index]
               }
           }
       }
 
}








































