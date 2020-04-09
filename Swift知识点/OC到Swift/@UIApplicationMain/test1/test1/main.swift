//
//  main.swift
//  test1
//
//  Created by yunna on 2020/4/3.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit


UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(MyApplication.self),
    NSStringFromClass(AppDelegate.self)
)
 
