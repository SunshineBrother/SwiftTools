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
 
}








































