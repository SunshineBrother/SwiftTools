//
//  ValueChangeController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/16.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class ValueChangeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //把字符串转变为二进制
        let text = "ValueChangeController.swift"
        let data = ValueChange.data(from: text)
        let TEXT = ValueChange.jsonString(from: data)
        print(data)
        print(TEXT)
        
        ///json字符串和字典的转化
        let dic = ["one":"1","two":"2","three":"3"]
        let jsonStr = ValueChange.jsonString(from: dic)
        let dic1 = ValueChange.dictionary(from: jsonStr)
        print(jsonStr)
        print(dic1)
        
        /// data和字段的转化
        let dic2 = ["one":"1","two":"2","three":"3"]
        let data2 = ValueChange.data(from: dic2)
        let dic3 = ValueChange.dictionary(from: data2)
        print(data2)
        print(dic3)
 
        ///data和数组的转化
        let array = ["1","2","3"]
        let data3 = ValueChange.data(from: array)
        let array1 = ValueChange.array(from: data3)
        print(data3)
        print(array1)
        
    
    }

 

}
































