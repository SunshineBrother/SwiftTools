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

        //获取当前时间字符串
        print(Date().CurrentStingTime)
        // 获取当前时间 date
        print(Date().CurrentDateTime)
        //获取当前时间戳
        print(Date().CurrentStampTime)
        //获取当天0点时间戳
        print(Date().todayZeroStampTime)
        
        // date 转化为时间戳
        let date = Date(timeIntervalSince1970: 1517106797)
        let StampTime = Date().StampTime(from: date)
        print(StampTime)
        //date 转字符串
        let dateString = Date().dateString(from: date)
        print(dateString)
        
        // 时间戳转化为date
        let date1 = Date().date(from: 1517106797)
        print(date1)
        
        
        // 时间戳转化为字符串
        let text = Date().dateString(from: 1517106797)
        print(text)
        
        // 字符串转date
        let date2 = Date().date(from: text)
        print(date2)
        
        // 字符串转时间戳
        let Stamp1 = Date().StampTime(from: text)
        print(Stamp1)
        
        
        
    }

   

}
