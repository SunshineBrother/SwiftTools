//
//  Bundle+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import UIKit
extension Bundle {
    /// app版本号
    static var versionName: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    /// app构建次数
    static var build: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    /// app名字
    static var displayName: String {
        return Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }

    static var bundleId: String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
    }
}
