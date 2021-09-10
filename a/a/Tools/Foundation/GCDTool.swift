//
//  GCDTool.swift
//  a
//
//  Created by HM on 2021/9/9.
//


import Foundation

typealias HMGCDTask = (_ cancel: Bool) -> Void

@discardableResult
func delay(_ time: TimeInterval,
           task: @escaping () -> Void) -> HMGCDTask? {

    func dispatch_later(block: @escaping () -> Void) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }

    var closure: ( () -> Void)? = task
    var result: HMGCDTask?

    let delayedClosure: HMGCDTask = { cancel in
        if let internalClosure = closure {
            if cancel == false {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }

    result = delayedClosure
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }

    return result

}

func cancel(_ task: HMGCDTask?) {
    task?(true)
}

 
