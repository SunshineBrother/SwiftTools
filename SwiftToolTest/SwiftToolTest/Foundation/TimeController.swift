//
//  TimeController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class TimeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK:  -- 常用方法 -- 
        //获取当前时间字符串
        print(Date().CurrentStingTime)
        // 获取当前时间 date
        print(Date().CurrentDateTime)
        // date 转化为时间戳
        let date = Date().CurrentDateTime
        let StampTime = date.StampTime(from: date)
        print(StampTime)
        // 时间戳转化为date
        let date1 = Date().date(from: StampTime)
        print(date1)
        
        //MARK: -- 其他 --
        print(date.year)
        print(date.month)
        print(date.day)
        print(date.weekday)
        print(date.isToday)
        print(date.isTomorrow)
        
    }

   

}
