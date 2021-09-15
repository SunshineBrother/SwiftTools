//
//  Array+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import UIKit

extension Array where Element: Equatable {
  
    /// 删除  重复元素
    mutating func removedDuplicates() {
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }

    /// 移除对象
    mutating func remove(_ object: Element) {
        removeAll(where: { $0 == object })
     }
     
   
    /// 传入下标数组，获取该下标数组对应的数组值
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
               for (index, i) in input.enumerated() {
                   assert(i < self.count, "Index out of range")
                   self[i] = newValue[index]
               }
           }
       }
    
    
    /// 获取数组对象的下表
    /// - Parameter object: 数组对象
    /// - Returns: description
    func getIndex(_ object: Element) -> Int? {
        for (index, item) in self.enumerated() where object == item {
            return index
        }
        return nil
    }
  
}








































