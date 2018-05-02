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

///限制服务类型
enum LimitService_Type:String {
    ///相册权限
    case Service_PhotoAlbum = "Service_PhotoAlbum"
    ///相机权限
    case Service_Camera = "Service_Camera"
    ///麦克风权限
    case Service_Microphone = "Service_Microphone"
}


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
    
    
    /// 权限服务
    ///
    /// - Parameter type: 类型
    /// - Returns: 返回结果
    func isAllowService(type:LimitService_Type) -> Bool {
        ///返回结果
        var result = false
        
        switch type {
        case LimitService_Type.Service_Camera:
            
            break
        default:
            break
        }
        
        
        return result
    }
    
}
//MARK: --  权限 --
extension ServiceManager {
   
    /// 是否允许获取相册权限
   private func isAllowPhotoAlbumService() -> Bool {
        let photoAuthorStatus = PHPhotoLibrary.authorizationStatus()
        if photoAuthorStatus == PHAuthorizationStatus.authorized{
            return true
        }else{
            return false
        }
        
    }
    /// 是否允许获取相机权限
    private func isAllowCameraService() -> Bool {
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if videoAuthStatus == AVAuthorizationStatus.authorized{
            return true
        }else{
            return false
        }
      
    }
    
    ///是否允许麦克风权限
   private func isAllowMicrophoneService() -> Bool {
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        if videoAuthStatus == AVAuthorizationStatus.authorized{
            return true
        }else{
            return false
        }
        
    }
    
   
}









































