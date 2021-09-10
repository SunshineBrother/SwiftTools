//
//  NetworkConstant.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation

struct NetworkConstant {
    
    static let timeoutInterval: TimeInterval = 10  // 网络请求超时时间
    static let successCode = "0"  // 请求成功返回的code值
    static let tokenExpiryCode = "501"  // token过期,请续约
    static let logoutCode: [String] = [] // 登出code
}

 
