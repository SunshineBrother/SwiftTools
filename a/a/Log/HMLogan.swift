//
//  HMLogan.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import UIKit
import Logan

enum HMLoganType: UInt {
    case action = 1 // 用户行为日志
    case network = 2 // 网络级日志
}

class HMLogan: NSObject {
    
    /// 将日志输出至控制台, 默认打印
    var isPrint = true {
        didSet {
            loganUseASL(isPrint)
        }
    }
    
    static let shareManager = HMLogan()
    private
    override init() {
        super.init()
        
        loganUseASL(true)
    }
    
    
    /// 初始化
    /// - Parameters:
    ///   - key: 16位aes加密key
    ///   - iv: 16位aes加密iv
    func initLogan(key: String, iv: String) {
        guard let keyData = key.data(using: .utf8),
              let ivData = iv.data(using: .utf8) else {
            return
        }
        // 文件最大
        let maxFileSize: UInt64 = 10 * 1024 * 1024
        loganInit(keyData, ivData, maxFileSize)
    }
    
    /// 设置本地保存最大文件天数，默认7天
    func setMaxReversedDate(maxDay: Int = 7) {
        loganSetMaxReversedDate(Int32(maxDay))
    }
    
    
    /// 记录日志
    /// - Parameters:
    ///   - msg: 日志内容
    ///   - type: 日志类型
    func logans(msg: String, type: HMLoganType = .action) {
        logan(type.rawValue, msg)
    }

    
    
    /// 根据日期获取上传日志的文件路径，异步方式！
    /// - Parameters:
    ///   - date: 日志日期 格式："2021-9-1"
    ///   - filePathClouse: 回调返回文件路径，在主线程中回调
    func loganFilePath(date: String = loganTodaysDate(), filePathClouse:  @escaping (_ filePath: String?) -> Void) {
        loganUploadFilePath(date) { path in
            filePathClouse(path)
        }
    }
    
    
    /// 上传指定日期的日志
    /// - Parameters:
    ///   - url: 接受日志的服务器完整url
    ///   - date: 日志日期 格式："2021-9-1"
    ///   - appId: 当前应用的唯一标识,在多App时区分日志来源App
    ///   - unionId: 当前用户的唯一标识,用来区分日志来源用户
    ///   - deviceId: 设备id
    ///   - finishedCallback: finishedCallback description
    func logansUpload(url: String,
                      date: String = loganTodaysDate(),
                      appId: String,
                      unionId: String,
                      deviceId: String,
                      finishedCallback:  @escaping (_ completion: Bool) -> Void) {
        loganUpload(url, date, appId, unionId, deviceId) { _, _, error in
            let result = error == nil ? true : false
            finishedCallback(result)
        }
        
    }
    
    
    /// 清除本地所有日志
    func cleanAllLogan() {
        loganClearAllLogs()
    }
    
    
    
    
}
