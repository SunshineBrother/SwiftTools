//
//  main.swift
//  函数式思想
//
//  Created by yunna on 2020/4/9.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

typealias Distance = Double
//1
struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func within(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
}

//2
struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}
























