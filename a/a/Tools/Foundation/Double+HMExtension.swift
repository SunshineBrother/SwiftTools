//
//  Double+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import Foundation
extension Double {
    /*
     let d: Double = 1.23456
     print(d.format(".2"))
     */
    
    /// 保留几位小说
    /// - Parameter f: 保留位数
    func format(_ f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    
    
}
