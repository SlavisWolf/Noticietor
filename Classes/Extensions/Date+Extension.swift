//
//  Date+Extension.swift
//  
//
//  Created by Antonio Jesús
//

import  UIKit
extension Date {
    
    func toString(_ format: String = Formatter.serverDateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
