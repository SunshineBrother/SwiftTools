//
//  Expiry.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation

/// 过期时间
public enum Expiry {
    /// 永久
    case never
    /// 对象将在指定的秒数内过期
    case time(Time)
    /// 对象将在指定日期过期
    case date(Date)

    var date: Date {
        switch self {
        case .never:
            return Date(timeIntervalSinceNow: Time.year(30).seconds)
        case .time(let s):
            return Date().addingTimeInterval(s.seconds)
        case .date(let date):
            return date
        }
    }
}

extension Expiry {
    public enum Time {
        case seconds(Int)
        case minute(Int)
        case hour(Int)
        case day(Int)
        case month(Int)
        case year(Int)
    }
}

extension Expiry.Time {
    var seconds: TimeInterval {
        switch self {
        case .seconds(let s):
            return TimeInterval(s)
        case .minute(let m):
            return TimeInterval(60 * m)
        case .hour(let h):
            return TimeInterval(60 * 60 * h)
        case .day(let d):
            return TimeInterval(60 * 60 * 24 * d)
        case .month(let mt):
            return TimeInterval(60 * 60 * 24 * 30 * mt)
        case .year(let y):
            return TimeInterval(60 * 60 * 24 * 30 * 12 * y)
        }
    }
}
