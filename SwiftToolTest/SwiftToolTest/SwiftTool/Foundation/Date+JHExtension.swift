//
//  Date+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
enum MyDateFormatter:String{
    case dateModeY = "yyy"
    case dateModeYM = "yyy-MM"
    case dateModeYMD = "yyy-MM-dd"
    case dateModeYMDHMS = "yyy-MM-dd HH:mm:ss"
    case dateModeYMDHMSSS = "yyy-MM-dd HH:mm:ss SSS"
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
/// - Parameter mode: mode description
func getCurrentStampTime() ->Int{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
    let dataString = dateFormatter.string(from: Date())
    let date = dateFormatter.date(from: dataString)
    let stamp = date!.timeIntervalSince1970
    
    return Int(stamp)
}


/// 时间戳转字符串
/// - Parameter stamp: stamp description
func toStringTime(stamp:Int) -> String {
    let timeInterval:TimeInterval = TimeInterval(stamp)
    let date = Date(timeIntervalSince1970: timeInterval)
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = dateformatter.string(from: date)
    
    return dateString
}


/// 字符串转时间戳
/// - Parameter strTime: strTime description
func toStampTime(strTime:String) -> Int {
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let current = dateFormatter.date(from: strTime)
    let date = Date.init(timeInterval: 0, since: current ?? Date())
    let stamp = date.timeIntervalSince1970
    return Int(stamp)
}




//MARK:-- 常用方法 --
extension Date{
 
    ///获取当天0点时间戳
    public var todayZeroStampTime:Int{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateString = dateFormatter.string(from: currentDate)
        let zeroStr = dateString + " 00:00:00"
        return toStampTime(strTime: zeroStr)
    }
 
}
//MARK: -- 其他 --
extension Date{
    /// 年
    public var year: Int {
        return NSCalendar.current.component(.year, from: self)
    }
    /// 月
    public var month: Int {
        return NSCalendar.current.component(.month, from: self)
    }
    /// 日
    public var day: Int {
        return NSCalendar.current.component(.day, from: self)
    }
    /// 周几
    public var weekday: String {
        let weekdays = [NSNull.init(),"星期天","星期一","星期二","星期三","星期四","星期五","星期六"] as [Any]
        var calendar = Calendar(identifier:.gregorian)
        
        let timeZone = NSTimeZone.init(name: "Asia/Shanghai")
        
        calendar.timeZone = timeZone! as TimeZone
        
        let theComponents = calendar.dateComponents([.year,.month, .day,.weekday, .hour,.minute,.second], from: self)
        
        return weekdays[theComponents.weekday!] as! String
    }
    
    /// 是否在将来
    public var isFuture: Bool {
        return self > Date()
    }
    
    /// 是否在过去
    public var isPast: Bool {
        return self < Date()
    }
    /// 是否是今天
    public var isToday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self) == format.string(from: Date())
    }
    
    /// 是否是昨天
    public var isTomorrow: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        return format.string(from: self) == format.string(from: tomorrow!)
    }
  
}





























