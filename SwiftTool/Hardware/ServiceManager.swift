//
//  ServiceManager.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/4/28.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import Photos
import AVFoundation


class ServiceManager: NSObject {}
//MARK: -- 权限跳转 --
extension ServiceManager {
    ///开启权限
    func TurnOnServeManager() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [String:Any](), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
        }
    }
}
//MARK: -- 相机&相册&麦克风 权限 --
extension ServiceManager {
    
    /// 是否允许获取相册权限
    func isAllowPhotoAlbumService() -> Bool {
        let photoAuthorStatus = PHPhotoLibrary.authorizationStatus()
        if photoAuthorStatus == PHAuthorizationStatus.authorized{
            return true
        }else{
            return false
        }
       
    }
  
    /// 是否允许获取相机权限
    func isAllowCameraService() -> Bool {
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if videoAuthStatus == AVAuthorizationStatus.authorized{
            return true
        }else{
            return false
        }
      
    }
    
    ///是否允许麦克风权限
    func isAllowMicrophoneService() -> Bool {
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        if videoAuthStatus == AVAuthorizationStatus.authorized{
            return true
        }else{
            return false
        }
        
    }
    
   
}









































