//
//  JHExtension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/10.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

/// 两个字典相加
/// - Parameters:
///   - left: left description
///   - right: right description
public func + <Key, Value>(left: [Key: Value], right: [Key: Value]) -> [Key: Value]{
    var result:[Key: Value] = left
    for (key,value) in right {
        result[key] = value
    }
    return result
}
 
extension Dictionary {
    
    ///拼接字典
    mutating func add(_ para:Dictionary?) -> Dictionary{
        if para != nil {
            for (key,value) in para! {
                self[key] = value
            }
        }
        return self
    }
  
    ///删除所有
    mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
    }
    
    
    /// json字符串转字典
    /// - Parameter json: json字符串
    public static func constructFromJSON(json: String) -> Dictionary? {
        if let data = (try? JSONSerialization.jsonObject(
            with: json.data(using: String.Encoding.utf8,
                            allowLossyConversion: true)!,
            options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary {
            return data
        } else {
            return nil
        }
    }
    
    ///Json字典转Json字符串
    func formatJSONString() -> String? {
        
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = JSONSerialization.WritingOptions.prettyPrinted
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    ///Json字典转Data
    func formatJSONData() -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = JSONSerialization.WritingOptions.prettyPrinted
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
}


















