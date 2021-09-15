//
//  UIImageView+Kingfisher.swift
//  a
//
//  Created by HM on 2021/9/9.
//


import UIKit
import Kingfisher
extension UIImageView {
    
    /// 加载网络请求
    /// - Parameters:
    ///   - urlString: url
    ///   - placeHolder: placeHolder
    func HM_setImage(with urlString: String,
                     placeHolder: String = "placeHold") {
        guard let url = URL(string: urlString) else {
            image = UIImage(named: placeHolder)
            return
        }
        let placeHolderImage = UIImage(named: placeHolder)
        kf.setImage(with: url, placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
    }
   
    
}

/// 移除kf缓存图片
func remove_kfCache() {
    let cache = ImageCache.default
    cache.clearDiskCache()
    cache.clearMemoryCache()
}


