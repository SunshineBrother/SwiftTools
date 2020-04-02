//
//  main.swift
//  动态运行
//
//  Created by yunna on 2020/3/27.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

class Pet {}
class Dog:Pet {}
class Cat:Pet {}
 
func eat(_ pet:Pet) {
    print("pet eat")
}

func eat(_ dog:Dog) {
    print("dog eat")
}

func eat(_ cat:Cat) {
    print("cat eat")
}
 
func eats(_ pet:Pet,_ cat:Cat) {
    eat(pet)
    eat(cat)
}
eats(Dog(), Cat())
//pet eat
//cat eat

func eats1(_ pet:Pet,_ cat:Cat) {
    if let aCat = pet as? Cat {
        eat(aCat)
    }else if let aDog = pet as? Cat{
        eat(aDog)
    }
    
    eat(cat)
}





























