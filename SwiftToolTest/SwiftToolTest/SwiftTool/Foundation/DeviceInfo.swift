//
//  DeviceInfo.swift
//  SwiftToolTest
//
//  Created by yunna on 2020/4/10.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit

class DeviceInfo{
    
    /// app名称
    public static var appDisplayName: String{
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        return ""
    }
    
    
    /// app版本号
    public static var appVersion: String{
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    }
    
    ///Build
    public static var appBuild: String{
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? "0"
    }
    
    
    /// bundleID
    public static var appBundleID: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    
    /// 设备信息
    public static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
}
