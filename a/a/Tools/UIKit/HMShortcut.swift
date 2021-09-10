//
//  HMShortcut.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import UIKit
/// 屏宽
public func kScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

/// 屏高
public func kScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

/// 是否是x系列
public let isIPhoneX = { () -> Bool in
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return false
        }
        if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
            return true
        }
    }
    return false
}

/// 状态栏高度
public let kStatusBarHeight = { () -> CGFloat in
    var statusBarHeight: CGFloat = 0
    if #available(iOS 13.0, *) {
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        statusBarHeight = statusBarManager?.statusBarFrame.size.height ?? 0
    } else {
        statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    }
    return statusBarHeight
}()

/// 导航栏高度
public let kNaviBarHeight: CGFloat = 44.0

/// 导航栏MaxY
public let kNaviBarMaxY = {
    kStatusBarHeight + kNaviBarHeight
}()

/// 底部安全距离
public let kSafeBottomArea = { () -> CGFloat in
    var safeBottom: CGFloat = 0
    if #available(iOS 11, *) {
        let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
        safeBottom = safeArea?.bottom ?? 0
    }
    return safeBottom
}()

/// tabbar高度
public let kTabBarHeight: CGFloat = 49.0

/// tabbar总高度
public let kTabBarMaxY: CGFloat = kTabBarHeight +  kSafeBottomArea




