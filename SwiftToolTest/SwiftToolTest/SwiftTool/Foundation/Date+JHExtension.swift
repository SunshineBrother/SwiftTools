//
//  Date+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
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
public let kDate_minute : Double = 60 ;
/// 3600s
public let kDate_hour : Double   = 3600 ;
/// 86400
public let kDate_day : Double    = 86400 ;
/// 604800
public let kDate_week : Double   = 604800 ;
/// 31556926
public let kDate_year : Double   = 31556926 ;



enum MyDateFormatter:String{
    case dateModeY = "yyyy"
    case dateModeYM = "yyyy-MM"
    case dateModeYMD = "yyyy-MM-dd"
    case dateModeYMDHMS = "yyyy-MM-dd HH:mm:ss"
    case dateModeYMDHMSSS = "yyyy-MM-dd HH:mm:ss SSS"
}

/// 获取当前时间字符串
/// - Parameter mode: mode
func getCurrentStingTime(_ mode:MyDateFormatter = .dateModeYMDHMS) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = mode.rawValue
    let dataString = dateFormatter.string(from: Date())
    return dataString
}

/// 获取当前时间戳
/// - Parameter isMS: 是否是毫秒级的
func getCurrentStampTime(isMS:Bool = true) ->Int{
    let dateFormatter = DateFormatter()
    var format = "yyyy-MM-dd HH:mm:ss.SSS"
    if isMS == false {
        format = "yyy-MM-dd HH:mm:ss"
    }
    dateFormatter.dateFormat = format
    let dataString = dateFormatter.string(from: Date())
    let date = dateFormatter.date(from: dataString)
    let stamp = date!.timeIntervalSince1970
    
    return isMS ? Int(stamp * 1000) : Int(stamp)
}


/// 时间戳转字符串
/// - Parameter stamp: stamp description
func toStringTime(stamp:Int,_ mode:MyDateFormatter = .dateModeYMDHMS) -> String {
    let timeInterval:TimeInterval = TimeInterval(stamp)
    let date = Date(timeIntervalSince1970: timeInterval)
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = mode.rawValue
    let dateString = dateformatter.string(from: date)
    
    return dateString
}


/// 字符串转时间戳
/// - Parameter strTime: strTime description
func toStampTime(strTime:String,_ mode:MyDateFormatter = .dateModeYMDHMS) -> Int {
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateFormat = mode.rawValue
    let current = dateFormatter.date(from: strTime)
    let date = Date.init(timeInterval: 0, since: current ?? Date())
    let stamp = date.timeIntervalSince1970
    return Int(stamp)
}


/// 时间字符串转自定义时间格式字符串
/// - Parameters:
///   - customFormat: 自定义格式字符串 例如:@"HH:mm MM/dd"
///   - timeStr: 原始时间格式字符串
///   - oldFormat: 老的时间格式，默认是：yyy-MM-dd HH:mm:ss
func getCustomFormatTime(customFormat:String,timeStr:String,oldFormat:MyDateFormatter = .dateModeYMDHMS) -> String {
    
    let fmt = DateFormatter()
    fmt.dateFormat = oldFormat.rawValue
    let date = fmt.date(from: timeStr)
    let customfmt = DateFormatter()
    customfmt.dateFormat = customFormat
    let resultStr = customfmt.string(from: date!)
     
    return resultStr
}




 



























