//
//  JHNetManagerAPI.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/10.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

enum MethodType {
    case get
    case post
}
class JHNetManagerAPI: NSObject {

    static let shareManager = JHNetManagerAPI()
    let manager:SessionManager
    private override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        manager = Alamofire.SessionManager(configuration: configuration)
        
    }
    
    //基础url
    let baseUrl = ""
    //基础参数
    var param = [String:String]()
    //请求头
    let headers: HTTPHeaders = [
        "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
        "Content-type":"application/json;charset=utf-8",
        "Accept":"application/json"
    ]
    
    /// 网络请求
    ///
    /// - Parameters:
    ///   - type: type
    ///   - URLString: url
    ///   - para: 参数
    ///   - ShowHUD: 是否显示加载框
    ///   - finishedCallback: 完成回调
    func JHRequestData(_ type : MethodType, URLString : String, para : [String : String]? = nil,ShowHUD:Bool, finishedCallback :  @escaping (_ result : Any?) -> ()) {
        if ShowHUD {
            JHProgressHUD.ShowloadingWithMessage(text: "加载中")
        }
        
        //拼接url&参数
        let URL = baseUrl + URLString
        if para != nil {
            for (key,value) in para! {
                param[key] = value
            }
        }
        ///请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        ///网络请求
        manager.request(URL, method: method, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            //隐藏加载框
            if ShowHUD {
                JHProgressHUD.dismissHUD()
            }
            // 获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                
                return
            }
            
            // 将结果回调出去
            finishedCallback(result)
          
        }
        
 
    }
    
    
    
}



















