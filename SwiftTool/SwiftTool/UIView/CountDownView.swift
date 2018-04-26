//
//  CountDownView.swift
//  Test
//
//  Created by yunna on 2017/12/18.
//  Copyright © 2017年 yunna. All rights reserved.
//

import UIKit

class CountDownView: UIView {
    
    private var sendButton: UIButton! //发送验证码按钮
    private var countdownTimer: Timer? //定时器
    private var completeClosure: (()->())? //点击倒计时的回调
    //倒计时事件
    var remainingSeconds: Int = 0 {
        willSet {
            sendButton.setTitle("\(newValue)s后重新获取", for: .normal)
            
            if newValue <= 0 {
                sendButton.setTitle("重新获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    //是否正在进行倒计时
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                //设置倒计时时间
                remainingSeconds = 4
                sendButton.isUserInteractionEnabled = false
                sendButton.backgroundColor = UIColor.gray
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                sendButton.isUserInteractionEnabled = true
                sendButton.backgroundColor = UIColor.red
            }
            
            sendButton.isEnabled = !newValue
        }
    }
    
     
   
    
    ///创建SendButton
    func CreateSendButtonWithAcceptEvent(complete:@escaping () -> Void) {
        sendButton = UIButton.init(frame: self.bounds)
        sendButton.setTitle("获取验证码", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonClick(sender:)),  for: .touchUpInside)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.addSubview(sendButton)
   
        sendButton.backgroundColor = UIColor.gray
        
        //闭包回调
        completeClosure = complete
    }
 
    
}

//MARK: -- 事件处理 --
extension CountDownView {
    
    
    ///开启倒计时
    func openCountDown() {
        isCounting = true
     
    }
    
    ///button事件
    @objc func sendButtonClick(sender:UIButton?){
        sender?.isUserInteractionEnabled = false
        ///防止连续点击
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sender?.isUserInteractionEnabled = true
        }
        
        //闭包回调
        if (completeClosure != nil) {
            completeClosure!()
        }
    }
    ///定时器事件
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }
    
    
    ///从父视图中移除  这个时候 移除定时器
    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        if (countdownTimer != nil) {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
        
    }
}


















