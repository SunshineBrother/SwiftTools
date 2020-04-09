//
//  main.swift
//  条件编译
//
//  Created by yunna on 2020/4/3.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation
import AVKit
 
class MyPerson {
    func MyPrint() {
        #if FREE_VERSION
        print("免费版本")
        #else
        print("付费版本")
        #endif
    }
    
    
    func myPrint1() {
        #if swift(>=14.0)
            print(">=14.0")
        #else
           print("<14.0")
        #endif

    }
}


 

#if os(macOS)
    typealias Color = NSColor
#else
    typealias Color = UIColor
#endif



#if arch(x86_64)
     
#else
     
#endif


#if swift(>=14.0)
     
#else
     
#endif




let p = MyPerson()
p.myPrint1()







































