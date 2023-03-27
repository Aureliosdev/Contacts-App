//
//  Contact.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 23.02.2023.
//

import Foundation

struct Contact: Codable {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    var imageData: Data?
}

struct ContactGroup {
    let title: String
    var contacts: [Contact]
}
