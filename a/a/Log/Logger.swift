//
//  Logger.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import Foundation
enum LoggerLevel: String {
    case normal = ""
    case info = "info"
    case error = "ERROR ‼️ " // error
    case warning = "WARNING ⚠️ " // warning
    case severe = "SEVERE 🔥 " // severe
}

class Logger {
    private init() {}

    
    /// 日志打印
    /// - Parameters:
    ///   - object: object description
    ///   - type: type description
    static func log(_ object: Any,
                    type: LoggerLevel = .normal,
                    filename: String = #file,
                    line: Int = #line,
                    funcname: String = #function) {
        #if DEBUG
        // 文件名
        let fileName = (filename as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        // line
        let fileLine = line
        // funcName
        let funcName = (funcname as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        // 时间
        let date = Date().toSting()
        
        // 具体信息
        var msg = ""
        if type != .normal {
            msg = date + " " + fileName + " " + "\(fileLine) " + funcName + " "
        }
        
        print(type.rawValue + msg + "\(object)")
         
        #endif
    }
}
