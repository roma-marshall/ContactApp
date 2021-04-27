//

import Foundation
import Contacts
import ContactsUI

struct Duplicate {
    let value: String
    let contacts: [Contact]
}

extension Duplicate: Identifiable {
    var id: String { return value }
}

extension Duplicate {
    func mergedContact() -> CNMutableContact {
        let newContact = CNMutableContact()
        newContact.givenName = contacts.first?.firstName ?? ""
        newContact.familyName = contacts.first?.lastName ?? ""
        newContact.phoneNumbers = contacts.first?.phones.map { CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: $0))} ?? [CNLabeledValue]()
        
        return newContact
    }
    
    func merge() throws -> CNContact {
        let newContact = mergedContact()
        
        let store = CNContactStore()
        
        // save contact
        let request = CNSaveRequest()
        request.add(newContact, toContainerWithIdentifier: nil)
        try store.execute(request)
        
        // delete old contacts
        let predicate = CNContact.predicateForContacts(withIdentifiers: contacts.map {$0.id})
        let contactsToDelete = try store.unifiedContacts(matching: predicate, keysToFetch: [])
        
        let request2 = CNSaveRequest()
        contactsToDelete.forEach {
            request2.delete($0.mutableCopy() as! CNMutableContact)
        }
        try store.execute(request2)
        
        return newContact
        
        
    }
}
