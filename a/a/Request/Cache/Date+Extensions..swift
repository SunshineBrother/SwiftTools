//
//  Date+Extensions..swift
//  a
//
//  Created by HM on 2021/9/9.
//

import Foundation

/**
 Helper NSDate extension.
 */
extension Date {

    /// 检查日期是否过期
    /// Checks if the date is in the past.
    var inThePast: Bool {
        return timeIntervalSinceNow < 0
    }
    /// 时间转字符串
    /// - Parameter format: Date format (default is "yyyy-MM-dd")
    /// - Returns: date string
    func string(withFormat format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
