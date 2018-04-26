//
//  TimeUntil.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/4.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class TimeUntil: NSObject {

    /// 获取当前时间 字符串
    class func CurrentStingTime() -> String {
        let currentDate = Date.init()
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dataString = dateFormatter.string(from: currentDate)
        
        return dataString
    }
    
    
    /// 获取当前时间 date
   class func CurrentDateTime() -> Date {
        let date = Date.init(timeInterval: 60*60*8, since: Date.init())
        return date
    }
    
    /// 返回当前时间戳
   class func CurrentStampTime() -> u_long {
        let date = Date.init(timeInterval: 60*60*8, since: Date.init())
        let stamp = date.timeIntervalSince1970
        
        return u_long(stamp)
    }
    
    ///返回 星期
    func getTheDayOfTheWeekByDateString(date:String) -> String {
        let dateString = (date as NSString).substring(to: 10)
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let inputDate = inputFormatter.date(from: dateString)
        let weekdays = [NSNull.init(),"星期天","星期一","星期二","星期三","星期四","星期五","星期六"] as [Any]
        var calendar = Calendar(identifier:.gregorian)
        
        let timeZone = NSTimeZone.init(name: "Asia/Shanghai")
        
        calendar.timeZone = timeZone! as TimeZone
        
        let theComponents = calendar.dateComponents([.year,.month, .day,.weekday, .hour,.minute,.second], from: inputDate!)
        
        return weekdays[theComponents.weekday!] as! String
    }
    
}
