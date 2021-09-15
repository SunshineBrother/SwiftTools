//
//  HMErrorFile.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import Foundation
struct HMError: Error {
    var reason: String = ""
    var code: String = ""
    init(code: String, reason: String) {
        self.code = code
        self.reason = reason
    }
    init(reason: String) {
        self.reason = reason
    }
}

