//
//  ContactManager.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 23.02.2023.
//

import Foundation


class ContactManager {
    
    let userDefaults: UserDefaults = UserDefaults.standard
    
    let userDefaultsKEY: String = "userDefaultsKEY"
    
    func getAllContacts() -> [Contact] {
        
        var allContacts: [Contact] = []
        
        let decoder = JSONDecoder()
        do {
            if let data = userDefaults.object(forKey: userDefaultsKEY) as? Data {
                allContacts = try decoder.decode([Contact].self, from: data)
            }
        }catch {
            print(error)
        }
        
        return allContacts
    }

    func saveContacts(allContacts: [Contact]) {
    
        do {
            
            let result = try JSONEncoder().encode(allContacts)
            userDefaults.set(result, forKey: userDefaultsKEY)
        }catch {
            print(error.localizedDescription)
        }
    
    }
    
    
    func add(contact: Contact) {
        
        var allContacts = getAllContacts()
        
        allContacts.append(contact)
        
        saveContacts(allContacts: allContacts)
    }
    
    func deleteContact(contactToDelete: Contact) {
        var allContacts = getAllContacts()
        
        for contact in 0..<allContacts.count {
            let singleContact = allContacts[contact]
            if singleContact.firstName == contactToDelete.firstName && singleContact.lastName == contactToDelete.lastName && singleContact.phoneNumber == contactToDelete.phoneNumber {
                allContacts.remove(at: contact)
            }
        }
        saveContacts(allContacts: allContacts)
        
        
    }
    
    func editContact(contactToEdit: Contact, editedContact: Contact)  {
        
        var allContacts = getAllContacts()
        
        
        for contact in 0..<allContacts.count {
            let singleContact = allContacts[contact]
            if singleContact.firstName == contactToEdit.firstName && singleContact.lastName == contactToEdit.lastName && singleContact.phoneNumber == contactToEdit.phoneNumber {
                allContacts.remove(at: contact)
                allContacts.insert(editedContact, at: contact)
            }
        }
        saveContacts(allContacts: allContacts)
    }
}
