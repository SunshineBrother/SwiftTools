//
//  LocationTool.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/7/12.
//  Copyright © 2018年 yunna. All rights reserved.
//
/*
 //获取城市
 NSString *city = placemark.locality;
 if (!city) {
 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
 city = placemark.administrativeArea;
 }
 NSLog(@"city = %@", city);//城市
 NSLog(@"--%@",placemark.name);//街道
 NSLog(@"++++%@",placemark.subLocality); //区
 NSLog(@"country == %@",placemark.country);//国家
 NSLog(@"administrativeArea == %@",placemark.administrativeArea); //省
 */

import UIKit
import CoreLocation
class LocationTool: NSObject,CLLocationManagerDelegate {
    ///单例
    static let sharedInstance = LocationTool()
    private override init() {}
    ///管理对象
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    //经纬度回调
    private var coordinateClose:((CLLocationCoordinate2D) -> ())?
    //具体地址回调
    private var addressClose:((CLPlacemark) -> ())?
    
    
    /// 获取用户地理信息
    ///
    /// - Parameters:
    ///   - coordinateCallBack: 经纬度
    func getUserCoordinate(_ coordinateCallBack: @escaping (_ coordinate : CLLocationCoordinate2D?) -> (), _ addressCallBack:@escaping (_ Placemark : CLPlacemark?) -> ()) {
        guard CLLocationManager.locationServicesEnabled() else {
            JHProgressHUD.ShowMessage(text: "定位服务当前可能尚未打开，请设置打开！")
            return
        }
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.coordinateClose = coordinateCallBack
        self.addressClose = addressCallBack
    }
    
    
   
}

extension LocationTool{
    //一次定位
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 获取最新的经纬度
        guard locations.count > 0 else {
            return
        }
        let newLocation = locations[locations.count - 1]
        let coor = newLocation.coordinate
        //经纬度
        if self.coordinateClose != nil {
            self.coordinateClose!(coor)
        }
        //将经纬度转换为城市名
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(newLocation) { (placemark, error) -> Void in
            guard error == nil else{
                return
            }
            let array = placemark! as NSArray
            guard array.count > 0 else{
                return
            }
            let mark = array.firstObject as! CLPlacemark
            if self.addressClose != nil{
                self.addressClose!(mark)
            }
        }
        
        self.locationManager.stopUpdatingLocation()
     
    }
 
   
    //定位出错
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if CLLocationManager.authorizationStatus() == .denied{
            //用户禁止使用权限
        }
    }
    
}















