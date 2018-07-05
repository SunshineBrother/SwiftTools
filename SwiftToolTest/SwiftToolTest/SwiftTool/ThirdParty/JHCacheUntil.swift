//
//  JHCacheUntil.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/7/4.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import YYCache
class JHCacheUntil: NSObject {
    private let JHRequestCache = "JHREQUESTCACHE"
    ///保存数据
    ///
    /// - Parameters:
    ///   - data: data
    ///   - key: key
    func saveData(data:Any, key:String) {
       
        
    }
    
    /// 获取数据
    ///
    /// - Parameter key: key
    /// - Returns: cachedata
    func getCacheData(key:String) -> Any {
        
        return ""
    }
    
    /// 根据key移除数据
    ///
    /// - Parameter key: key
    func removeObject(key:String) {
        
    }
    
    /// 移除所有数据
    func removeAllObject() {
        
    }
    
    /// 获取缓存路径
    ///
    /// - Returns:cachePath
    func cachePath() -> String {
        return ""
    }
    
    func cacheSize() -> String {
        
        return ""
    }
 
}






























