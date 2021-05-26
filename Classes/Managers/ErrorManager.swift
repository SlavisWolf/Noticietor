//
//  ErrrorManager.swift
//
//
//  Created by Antonio Jesús 
//

import  UIKit
class ErrorManager {
    
    static func createError(domain: String = "Error", code: Int = -1, info: Params? = nil) -> Error {
        NSError(domain: domain, code: code, userInfo: info)
    }
}


