//
//  main.swift
//  Tuple
//
//  Created by yunna on 2020/3/25.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

func swapMel1<T>(a:inout T, b:inout T) {
    let temp = a
    a = b
    b = temp
}

func swapMel2<T>(a:inout T, b:inout T) {
    (a,b) = (b,a)
}


