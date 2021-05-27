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
    
    func toDate(format: String = Formatter.articleFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: format)
    }
}
