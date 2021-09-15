//
//  Dictionary+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import Foundation

/// 两个字典相加
/// - Parameters:
///   - left: left description
///   - right: right description
public func + <Key, Value>(left: [Key: Value], right: [Key: Value]) -> [Key: Value] {
    var result: [Key: Value] = left
    for (key, value) in right {
        result[key] = value
    }
    return result
}
