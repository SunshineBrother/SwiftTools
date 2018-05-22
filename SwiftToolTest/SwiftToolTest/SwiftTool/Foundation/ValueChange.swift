//
//  ValueChange.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/16.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class ValueChange: NSObject {

    /// 把字符串转变为data
    class func data(from jsonString:String) -> Data {
        let data = jsonString.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        
        return data!
    }
    /// data 转 字符串
    class func jsonString(from data:Data) -> String {
        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return str! as String
    }
    
    ///字典转换为JSONString
    class func jsonString(from dictionary:Dictionary<String, Any>) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try! JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    ///JSONString转换为字典
   class func dictionary(from jsonString:String) -> Dictionary<String, Any> {
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! Dictionary<String, Any>
        }
        
        return Dictionary()
    }
    /// 字典转二进制
    class func data(from jsonDic:Dictionary<String, Any>) -> Data {
        if (!JSONSerialization.isValidJSONObject(jsonDic)) {
            print("字典转二进制失败")
            return Data()
        }
        let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        
        return data!
    }
    
    /// 二进制转字典
    class func dictionary(from data:Data) -> Dictionary<String, Any> {
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        let dic = json as! Dictionary<String, Any>
        return dic
    }
    
    /// 数组转data
    class func data(from array:Array<Any>) -> Data {
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("数组转data")
            return Data()
        }
        let data = try? JSONSerialization.data(withJSONObject: array, options: [])
        
        return data!
    }
    /// data转数组
    class func array(from data:Data) -> Array<Any> {
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        let array = json as! Array<Any>
        return array
    }
    
    
    
 
    
    
}







































