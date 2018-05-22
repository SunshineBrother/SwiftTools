//
//  JHExtension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/10.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
extension Dictionary {
    
    ///拼接字典
    mutating func addDictionary(_ para:Dictionary?) -> Dictionary{
        if para != nil {
            for (key,value) in para! {
                self[key] = value
            }
        }
        return self
    }
    
    ///判断是否存在
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    ///删除所有
    mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
    }
    
    ///Json字典转Json字符串
    func jsonString(prettify: Bool = false) -> String? {
        
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    ///Json字典转Data
    func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
}


















