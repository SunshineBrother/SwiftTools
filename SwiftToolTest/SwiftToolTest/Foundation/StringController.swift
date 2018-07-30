//
//  StringController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/15.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class StringController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //URL编码
        let URL = "https://www.baidu.com"
        print(URL.urlEncoded)
        print(URL.base64)
        //字符串的截取
        let TEXT = "https://www.baidu.com"
        print(TEXT.subStringFrom(index: 2, length: 5))
        print(TEXT.substring(from: 2, to: 5))
        print(TEXT.substring(to: 5))
        print(TEXT.substring(from: 5))
        //字符串的替换
        var TEXT2 = "https://www.baidu.com.www"
        print(TEXT2.stringByReplacingCharactersInRange(index: 0, length: 5, replacText: "liuyifei"))
        print(TEXT2.stringByReplacingstringByReplacingString(text: "www", replacText: "/hhh/"))
        //删除
        var TEXT3 = "https://www.baidu.com"
        print(TEXT3.deleteEndCharacters())
        print(TEXT3.deleteString(string: "https"))
        
        // 类型转化
        let TEXT4 = "123"
        let TEXT5 = "abc"
        print("TEXT4:\(TEXT4.toInt())==\(TEXT5.toInt())")
    
        //字符串的插入
        var TEXT6 = "20180720"
        print(TEXT6.insertString(text: "-", index: 4))
        print(TEXT6.insertString(text: "heheda", index: 4))
        
        
        
        
    }

    
}
