//
//  ConstantsFile.swift
//  Test
//
//  Created by yunna on 2017/12/7.
//  Copyright © 2017年 yunna. All rights reserved.
//

import Foundation
import UIKit

///随机色
func randomColor() ->  UIColor{
    let r = Int(arc4random_uniform(255))
    let g = Int(arc4random_uniform(255))
    let b = Int(arc4random_uniform(255))
    return Color(red: r, green: g, blue: b)!
}

///RGB转化
func JHRGB(r:CGFloat,g:CGFloat,b:CGFloat) ->UIColor{
    return UIColor(red: r/225.0, green: g/225.0, blue: b/225.0, alpha: 1.0)
}
///十六进制转化颜色
func JHColorFromRGB(rgb:NSInteger) -> UIColor {
     
    return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                   alpha: 1.0)
    
}

///背景灰
let JHGrayBG = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
///浅灰色字体
let JHWordColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
///深灰色
let JHWordColorDark = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
///红色
let JHRedColor = UIColor(red: 207/255.0, green: 28/255.0, blue: 44/255.0, alpha: 1)
///橘红
let JHOrange = UIColor(red: 225/255.0, green: 126/255.0, blue: 0/255.0, alpha: 1)



let JHScreenSize = UIScreen.main.bounds
let JHScreenWidth = UIScreen.main.bounds.size.width
let JHScreenHeight = UIScreen.main.bounds.size.height
let JHiPhoneX = (JHScreenWidth == 375.0 && JHScreenHeight == 812.0) ? true : false

let JHStatusBarAndNavigationBarHeight = JHiPhoneX ? 88.0 : 64.0
let JHTabbarHeight = JHiPhoneX ? (49.0+34.0) : 49.0

///切圆角&加边框
func JHViewBorderRadius(view:UIView, Radius:Float,Width:Float,Color:UIColor) {
    view.layer.cornerRadius = CGFloat(Radius)
    view.layer.borderWidth = CGFloat(Width)
    view.layer.borderColor = Color.cgColor
    
}
///设置圆角
func JHViewRadius(view:UIView, Radius:Float) {
    view.layer.cornerRadius = CGFloat(Radius)
}



/// 输出日志
///
/// - parameter message:  日志消息
/// - parameter logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出
/// - parameter file:     文件名
/// - parameter method:   方法名
/// - parameter line:     代码行数
func printLog<T>(message: T,
                 logError: Bool = false,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line)
{
    if logError {
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    } else {
        #if JH_Debug || JH_Debug_Demo
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
}



















