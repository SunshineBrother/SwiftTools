//
//  test.swift
//  柯里化1
//
//  Created by yunna on 2020/3/24.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>:
                            TargetAction {
    weak var target: T?
    let action: (T) -> () -> ()

    func performAction() -> () {
        if let t = target {
            action(t)()
        }
    }
}
 
enum ControlEvent {
    case TouchUpInside
    case ValueChanged
    
}


class Control {
    var actions = [ControlEvent: TargetAction]()

    func setTarget<T: AnyObject>(target: T,
                   action: @escaping (T) -> () -> (),
                controlEvent: ControlEvent) {

        actions[controlEvent] = TargetActionWrapper(
            target: target, action: action)
    }

    func removeTargetForControlEvent(controlEvent:  ControlEvent) {
            actions[controlEvent] = nil
    }

    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}
