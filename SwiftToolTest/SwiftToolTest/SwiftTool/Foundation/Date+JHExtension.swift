//
//  Date+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

//MARK:-- 常用方法 --
extension Date{
    ///获取当前时间字符串
    public var CurrentStingTime:String{
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dataString = dateFormatter.string(from: self)
        return dataString
    }
     
    /// 获取当前时间 date
    public var CurrentDateTime:Date{
        let date = Date.init(timeInterval: 60*60*8, since: self)
        return date
    }
    
    ///获取当前时间戳
    public var CurrentStampTime:u_long{
        let date = Date.init(timeInterval: 60*60*8, since: self)
        let stamp = date.timeIntervalSince1970
        return u_long(stamp)
    }
    
    /// date 转化为时间戳
    func StampTime(from date:Date) ->  u_long{
        return u_long(self.timeIntervalSince1970)
    }
    /// 时间戳转化为date
    func date(from StampTime:u_long) -> Date {
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(StampTime)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"

        return date as Date
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





























