//
//  ControllerTool.swift
//  SwiftToolTest
//
//  Created by yunna on 2020/4/10.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit

///根据类名生成controller
func getControllerByCls(clsName:String) -> UIViewController{
    //生成相应的类
    let nameSpace = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    guard let _cls = NSClassFromString(nameSpace + "." + clsName) as? NSObject.Type else {
        return UIViewController()
    }
    
    let mapCls = _cls.init() as! UIViewController
    return mapCls
}
