//

import Foundation
import Contacts

class ContactsManager {
    public private(set) var allContacts = [Contact]()
    
    public func refetchContacts(completion: @escaping (Result<Void, Swift.Error>) -> Void) {
        requestAccess {[weak self] (result) in
            let newResult = result.flatMap { (_) -> Result<Void, Swift.Error> in
                return Result<Void, Swift.Error> {
                    try self?.fetchContacts()
                }
            }
            completion(newResult)
        }
    }
    
    public func firstNameDuplicates() -> [Duplicate] {
        var dictionary = [String: [Contact]]()
        allContacts.forEach {
            let fullName = [$0.firstName, $0.lastName].compactMap({value in value == "" ? nil : value}).joined(separator: " ")
            var array = dictionary[fullName] ?? [Contact]()
            array.append($0)
            dictionary[fullName] = array
        }
        dictionary = dictionary.filter {
            $0.value.count > 1 && $0.key != ""
        }
        let duplicates = dictionary.map {Duplicate(value: $0.key, contacts: $0.value)}
        return duplicates
    }
    
    public func phoneDuplicates() -> [Duplicate] {
        var dictionary = [String: [Contact]]()
        allContacts.forEach { contact in
            contact.phones.forEach { phone in
                var array = dictionary[phone] ?? [Contact]()
                array.append(contact)
                dictionary[phone] = array
            }
        }
        dictionary = dictionary.filter {
            $0.value.count > 1
        }
        let duplicates = dictionary.map {Duplicate(value: $0.key, contacts: $0.value)}
        return duplicates
    }
    
    public func emailDuplicates() -> [Duplicate] {
        var dictionary = [String: [Contact]]()
        allContacts.forEach { contact in
            contact.emails.forEach { email in
                var array = dictionary[email] ?? [Contact]()
                array.append(contact)
                dictionary[email] = array
            }
        }
        dictionary = dictionary.filter {
            $0.value.count > 1
        }
        let duplicates = dictionary.map {Duplicate(value: $0.key, contacts: $0.value)}
        return duplicates
    }
    
    public func noName() -> [Contact] {
        return allContacts.filter{$0.firstName == ""}
    }
    
    public func noPhone() -> [Contact] {
        return allContacts.filter{$0.phones.count == 0}
    }
    
    public func noData() -> [Contact] {
        return allContacts.filter{$0.phones.count == 0 && $0.emails.count == 0}
    }
    
    public func birthday() -> [BirthdaySection] {
        let filteredContacts = allContacts.filter{$0.birthday != nil}
        var dictionary = [DateComponents : [Contact]]()
        filteredContacts.forEach { contact in
            var array = dictionary[contact.birthday!] ?? [Contact]()
            array.append(contact)
            dictionary[contact.birthday!] = array
        }
        return dictionary.map {BirthdaySection(title: $0.key.titleString(), contacts: $0.value)}
    }
    
    public func company() -> [CompanySection] {
        let filteredContacts = allContacts.filter{$0.company != nil && $0.company.count != 0}
        var dictionary = [String : [Contact]]()
        filteredContacts.forEach { contact in
            var array = dictionary[contact.company] ?? [Contact]()
            array.append(contact)
            dictionary[contact.company] = array
        }
        return dictionary.map {CompanySection(title: $0.key, contacts: $0.value)}
    }
}

extension ContactsManager {
    //MARK: Private interface
    private func requestAccess(completion: @escaping (Result<Void, Swift.Error>) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized: completion(.success(()))
        case .denied, .restricted: completion(.failure(Error.accessRestricted))
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { (response, error) in
                let result = Result<Void, Swift.Error> {
                    if let error = error {
                        throw error
                    }
                    switch response {
                    case true: return
                    case false: throw Error.accessRestricted
                    }
                }
                completion(result)
            }
        default: completion(.failure(Error.accessRestricted))
        }
    }
    private func fetchContacts() throws {
        let containerID = CNContactStore().defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerID)
        let descriptor =
            [
                CNContactIdentifierKey,
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactPhoneNumbersKey,
                CNContactEmailAddressesKey,
                CNContactBirthdayKey,
                CNContactOrganizationNameKey
            ]
            as [CNKeyDescriptor]
        self.allContacts = try CNContactStore().unifiedContacts(matching: predicate, keysToFetch: descriptor).map {
            Contact(
                id: $0.identifier,
                firstName: $0.givenName,
                lastName: $0.familyName,
                phones: $0.phoneNumbers.map{$0.value}.map{$0.stringValue},
                emails: $0.emailAddresses.map{$0.value}.map{String($0)},
                birthday: $0.birthday,
                company: $0.organizationName
            )
        }
    }
}

extension ContactsManager {
    // MARK: Nested objects
    enum Error: Swift.Error {
        case accessRestricted
    }
}

extension ContactsManager: ObservableObject {
    
}

extension DateComponents {
    func titleString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: Calendar.current.date(from: self) ?? Date())
    }
}
