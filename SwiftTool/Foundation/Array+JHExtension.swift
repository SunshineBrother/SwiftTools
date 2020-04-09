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
 
    
}








































