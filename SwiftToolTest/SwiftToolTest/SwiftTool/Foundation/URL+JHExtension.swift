//
//  URL+JHExtension.swift
//  SwiftToolTest
//
//  Created by yunna on 2020/8/19.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit

extension URL {
    
    /// 快速实现获取url中的参数，直接返回json对象
    public var parametersFromQueryString : [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
        let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
