//
//  ContactType.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 23.02.2023.
//

import Foundation

enum ContactType {
    case call
    case message
    case faceTime
    
    var urlScheme: String {
        switch self {
        case .call:
            return "tell://"
        case .message:
            return "sms://"
        case .faceTime:
            return "facetime://"
        }
    }
}
