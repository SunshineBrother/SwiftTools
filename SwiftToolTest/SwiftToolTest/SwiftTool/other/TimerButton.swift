//
//  TimerButton.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/7/27.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
class TimerButton: UIButton {
    
    ///是否开启倒计时
    var isWorking: Bool = false {
        didSet{
            if isWorking == true {
                self.countTime = self.timeLength
                self.countdownTimer.fireDate = NSDate.distantPast

            }else{
                self.countdownTimer.fireDate = NSDate.distantFuture
            }
        }
    }
    
    //定时器
    private lazy var countdownTimer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        return timer
    }()
    ///前缀描述
    private var prefix = ""
    private var start = ""
    //点击回调
    private var clickBtnClose:(()->())!
    //倒计时的总长度
    private var timeLength = 0
    ///倒计时时间
    private var countTime: Int = 0
    
    /// 定时器相关设置
    ///
    /// - Parameters:
    ///   - start: 起始状态
    ///   - prefix: 前缀
    ///   - countTime: 倒计时时间
    ///   - clickClose: 点击回调
    func setUP(start:String,prefix:String,countTime:Int,clickClose:@escaping () -> Void) {
        self.start = start
        self.prefix = prefix
        self.timeLength = countTime
        self.countTime = countTime
        self.clickBtnClose = clickClose
        self.setTitle(self.start, for: .normal)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.addTarget(self, action: #selector(clickBtnEvent), for: .touchUpInside)
    }
    

}


extension TimerButton{
    
    //点击事件
    @objc func clickBtnEvent(){
        if self.clickBtnClose != nil {
            self.clickBtnClose!()
        }
        
    }
    
    ///定时器事件
    @objc func updateTime(_ timer: Timer) {
        self.countTime -= 1
        
        if countTime > 0 {
            self.isUserInteractionEnabled = false
            self.setTitle(prefix + "\(countTime)s", for: .normal)
        }else{
            self.setTitle(start, for: .normal)
            self.isUserInteractionEnabled = true
            self.isWorking = false
        }
    }
    
    
}








