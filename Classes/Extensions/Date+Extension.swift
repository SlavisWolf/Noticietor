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
    
    func toStringWith8601() -> String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
    
    static func castStringWith8601Format(_ string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: string)
    }
}
