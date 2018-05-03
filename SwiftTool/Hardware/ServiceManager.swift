//
//  ServiceManager.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/4/28.
//  Copyright © 2018年 yunna. All rights reserved.


import UIKit
import Photos
import AVFoundation
import CoreLocation
import CoreTelephony
import EventKit
import CoreBluetooth
import Contacts

///限制服务类型
enum LimitService_Type:String {
    ///相册权限
    case Service_PhotoAlbum = "Service_PhotoAlbum"
    ///相机权限
    case Service_Camera = "Service_Camera"
    ///麦克风权限
    case Service_Microphone = "Service_Microphone"
    ///定位权限
    case Service_Location = "Service_Location"
    ///推送权限
    case Service_Notification = "Service_Notification"
    ///联网权限
    case Service_Network = "Service_Network"
    ///日历权限
    case Service_Calendars = "Service_Calendars"
    ///蓝牙权限
    case Service_Bluetooth = "Service_Bluetooth"
    ///通讯录权限
    case Service_Contacts = "Service_Contacts"
    
}


class ServiceManager: NSObject,CBCentralManagerDelegate {
    ///蓝牙权限获取回调
    private var completeBluetoothClosure: ((_ result:Bool)->())?
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var ret = false
        if central.state.rawValue == 5 {
            ret = true
        }
        if self.completeBluetoothClosure != nil {
            self.completeBluetoothClosure!(ret)
        }
        
    }
    
}
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
        case LimitService_Type.Service_PhotoAlbum:
            //相册权限
            result = self.isAllowPhotoAlbumService()
            break
        case LimitService_Type.Service_Camera:
            //相机权限
            result = self.isAllowCameraService()
            break
        case LimitService_Type.Service_Microphone:
            //相机权限
            result = self.isAllowMicrophoneService()
            break
        case LimitService_Type.Service_Location:
            //定位权限
            result = self.isAllowLocationService()
            break
        case LimitService_Type.Service_Network:
            //互联网权限
            result = self.isAllowNetworkService()
            break
        case LimitService_Type.Service_Calendars:
            //日历权限
            result = self.isAllowCalendarsService()
            break
        case LimitService_Type.Service_Bluetooth:
            //蓝牙权限
            self.isAllowBluetoothService { (ret) in
                result = ret
            }
            break
        case LimitService_Type.Service_Contacts:
            //通讯录权限
            result = self.isAllowContactsService()
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
    
    ///定位权限
    func isAllowLocationService() -> Bool  {
        let result = CLLocationManager.authorizationStatus()
        if  (result == CLAuthorizationStatus.denied) ||
            (result == CLAuthorizationStatus.notDetermined) ||
            (result == CLAuthorizationStatus.restricted){
            return false
        }
        
        return true
    }
    
    ///推送权限
    func isAllowNotificationService() -> Bool  {
        let setting = UIApplication.shared.currentUserNotificationSettings
        if setting?.types == UIUserNotificationType.sound {
            return false
        }
        return true
    }
    
    ///联网权限
    func isAllowNetworkService() -> Bool  {
        let state = CTCellularData().restrictedState
        if state == CTCellularDataRestrictedState.notRestricted {
            return true
        }
        
        return false
    }
    
    ///日历权限
    func isAllowCalendarsService() -> Bool  {
        let state = EKEventStore.authorizationStatus(for: EKEntityType.event)
        if state ==  EKAuthorizationStatus.authorized{
            return true
        }
        
        return false
    }
    ///蓝牙权限
    func isAllowBluetoothService(reslut:@escaping (Bool) -> Void) {
        let _ = CBCentralManager.init(delegate: self, queue: nil)
        completeBluetoothClosure = reslut
    }
    ///通讯录权限
    func isAllowContactsService() -> Bool  {
        let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        if status == CNAuthorizationStatus.authorized {
            return true
        }
        return false
    }
    
}









































