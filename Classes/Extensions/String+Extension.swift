//
//  String+Extension.swift
//  
//
//  Created by Antonio Jesús
//

import UIKit

extension String {
    
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
    
    func toDate(format: String = Formatter.serverDateFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: format)
    }
    
    var persistantHash: Int {
        return self.utf8.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
}
