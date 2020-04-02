//
//  main.swift
//  Sequence
//
//  Created by yunna on 2020/3/25.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

let animals = ["Antelope", "Butterfly", "Camel", "Dolphin"]
for animal in animals {
    print(animal)
}


//我们先实现一个IteratorProtocol协议类型
class ReverseIterator<T>: IteratorProtocol {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0

    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    func next() -> Element? {
        if currentIndex < 0{
            return nil
        }
        else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

// 然后我们来定义 Sequence
struct ReverseSequence<T>:Sequence {
    var array:[T]
    init (array: [T]) {
        self.array = array
    }
    typealias Iterator = ReverseIterator<T>
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
}

for item in ReverseSequence(array: animals){
    print(item)
}










 
