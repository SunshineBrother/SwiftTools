//
//  main.swift
//  associatedtype
//
//  Created by yunna on 2020/3/26.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

protocol Food { }

protocol Animal {
    associatedtype F: Food
    func eat(_ food: F)
 
}

struct Meat: Food { }
struct Grass: Food { }


//struct Tiger: Animal {
//    func eat(_ food: Food) {
//
//    }
//}
//

struct Tiger: Animal {
     func eat(_ food: Meat) {
         print("eat \(food)")
     }
 }


//func isDangerous(animal: Animal) -> Bool {
//    if animal is Tiger {
//        return true
//    } else {
//        return false
//    }
//}


func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Tiger {
        return true
    } else {
        return false
    }
}

isDangerous(animal: Tiger()) // true
 
