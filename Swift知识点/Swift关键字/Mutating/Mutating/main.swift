//
//  main.swift
//  Mutating
//
//  Created by yunna on 2020/3/25.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

 
protocol Vehicle {
    var numberOfWheels:Int{get}
    mutating func changeNumberOfWheels()
}

struct MyCar:Vehicle {
    var numberOfWheels: Int = 4
    
    mutating func changeNumberOfWheels() {
        numberOfWheels = 4
    }
}

class Cars: Vehicle {
    var numberOfWheels: Int = 0
    func changeNumberOfWheels() {
        numberOfWheels = 2
    }
}

