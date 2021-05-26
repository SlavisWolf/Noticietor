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
}
