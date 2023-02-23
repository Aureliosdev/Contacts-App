//
//  Extensions.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 23.02.2023.
//

import Foundation

extension String {
        func isValidPhoneNumber() -> Bool {
            
            let regEx = "^\\+(?:[0-9]?){6,14}[0-9]$"
            let phoneCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
            
            return phoneCheck.evaluate(with: self)
        }
    }
