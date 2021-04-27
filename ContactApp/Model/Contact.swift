//

import Foundation

struct Contact {
    let id: String
    let firstName: String
    let lastName: String
    let phones: [String]
    let emails: [String]
    let birthday: DateComponents?
    let company: String
}

extension Contact {
    func fullName() -> String {
        return firstName + " " + lastName
    }
}

extension Contact: Identifiable {
    
}
