//
//  JHRegularHelp.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class MyCountDownButton: UIButton {
    // 最大倒计时
    public var maxSecond = 60
    //判断是否处于倒计时状态
    public var countdown = false {
        didSet {
            if oldValue != countdown {
                countdown ? startCountdown() : stopCountdown()
            }
        }
    }
    
    private var second = 0
    private var timer: Timer?
    
    private var timeLabel = UILabel()
    private var normalText: String!
    private var normalTextColor: UIColor!
    private var disabledText: String!
    private var disabledTextColor: UIColor!
    
    deinit {
        countdown = false
    }
    
    // MARK: Setups
    private func setupLabel() {
        guard timeLabel.superview == nil else { return }
        
        normalText = title(for: .normal) ?? ""
        disabledText = title(for: .disabled) ?? ""
        normalTextColor = titleColor(for: .normal) ?? .white
        disabledTextColor = titleColor(for: .disabled) ?? .white
        setTitle("", for: .normal)
        setTitle("", for: .disabled)
        timeLabel.frame = bounds
        timeLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        timeLabel.textAlignment = .center
        timeLabel.font = titleLabel?.font
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
        addSubview(timeLabel)
    }
    
  
    private func startCountdown() {
        setupLabel()
        second = maxSecond
        updateDisabled()
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
        updateNormal()
    }
    
    private func updateNormal() {
        isEnabled = true
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
    }
    
    private func updateDisabled() {
        isEnabled = false
        timeLabel.textColor = disabledTextColor
        timeLabel.text = disabledText.replacingOccurrences(of: "second", with: "\(second)")
    }
    
    @objc private func updateCountdown() {
        second -= 1
        if second <= 0 {
            countdown = false
        } else {
            updateDisabled()
        }
    }

}
