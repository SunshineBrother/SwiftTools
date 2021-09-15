//
//  Date+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//


/*
 G:      公元时代，例如AD公元
 yy:     年的后2位
 yyyy:   完整年
 MM:     月，显示为1-12,带前置0
 MMM:    月，显示为英文月份简写,如 Jan
 MMMM:   月，显示为英文月份全称，如 Janualy
 dd:     日，2位数表示，如02
 d:      日，1-2位显示，如2，无前置0
 EEE:    简写星期几，如Sun
 EEEE:   全写星期几，如Sunday
 aa:     上下午，AM/PM
 H:      时，24小时制，0-23
 HH:     时，24小时制，带前置0
 h:      时，12小时制，无前置0
 hh:     时，12小时制，带前置0
 m:      分，1-2位
 mm:     分，2位，带前置0
 s:      秒，1-2位
 ss:     秒，2位，带前置0
 S:      毫秒
 Z：      GMT（时区）
 */

import UIKit

/// 60s
public let kDateMinute = 60
/// 3600s
public let kDateHour   = 3600
/// 86400
public let kDateDay    = 86400
/// 604800
public let kDateWeek   = 604800
/// 31556926
public let kDateYear   = 31556926



enum HMDateFormatter: String {
    case dateY = "yyyy" // 年
    case dateYM = "yyyy-MM" // 年月
    case dateYMD = "yyyy-MM-dd" // 年月日
    case dateYMDHMS = "yyyy-MM-dd HH:mm:ss" // 年月日 时分秒
    case dateYMDHMSSS = "yyyy-MM-dd HH:mm:ss SSS" // 年月日 时分秒 毫秒
    case dateEEE = "EEE" // 简写星期几，如Sun
    case dateEEEE = "EEEE" // 全写星期几，如Sunday
}


extension Date {
    /// date转string
    func toSting(_ mode: HMDateFormatter = .dateYMDHMS) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = mode.rawValue
        let dataString = dateFormatter.string(from: self)
        return dataString
    }
    
    
    ///  date转时间戳
    /// - Parameter isMS: 是否要毫秒
    func toStampTime(isMs: Bool = false) -> Int {
        let dateFormatter = DateFormatter()
        let format = isMs ? "yyyy-MM-dd HH:mm:ss.SSS" : "yyy-MM-dd HH:mm:s"
        dateFormatter.dateFormat = format
        let dataString = dateFormatter.string(from: self)
        let date = dateFormatter.date(from: dataString)
        guard let stamp = date?.timeIntervalSince1970 else {
            return 0
        }
        return isMs ? Int(stamp * 1000) : Int(stamp)
    }
}


extension Int {
    /// 时间戳转字符串
    /// - Parameters:
    ///   - isMs: 是否是毫秒
    ///   - mode: mode description
    /// - Returns: description
    func toStringTime(isMs: Bool = false, mode: HMDateFormatter = .dateYMDHMS) -> String {
        let time = isMs ? self / 1000 : self
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = mode.rawValue
        let dateString = dateformatter.string(from: date)
        return dateString
    }

}

extension String {
    /// 字符串转时间戳
    /// - Parameter strTime: strTime description
    func toStampTime(mode: HMDateFormatter = .dateYMDHMS) -> Int {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = mode.rawValue
        let current = dateFormatter.date(from: self)
        let date = Date.init(timeInterval: 0, since: current ?? Date())
        let stamp = date.timeIntervalSince1970
        return Int(stamp)
    }
    
    
    
    /// 时间字符串转时间Date
    /// - Parameter mode: mode description
    /// - Returns: description
    func toDate(mode: HMDateFormatter = .dateYMDHMS) -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = mode.rawValue
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
    }
    
    
    
    /// 时间格式转换
    /// - Parameter newFormat: newFormat description
    /// - Returns: description
    func toCustomFormatTime(newFormat: HMDateFormatter) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = fmt.date(from: self) else { return "" }
        let customfmt = DateFormatter()
        customfmt.dateFormat = newFormat.rawValue
        let resultStr = customfmt.string(from: date)
        return resultStr
    }
}









