//
//  main.swift
//  下标
//
//  Created by yunna on 2020/3/26.
//  Copyright © 2020 yunna. All rights reserved.
//

import Foundation

extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        set {
            for (index,i) in input.enumerated() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

var arr = ["a","b","c","d","z"]
print(arr[[0,3]]) //["a", "d"]















