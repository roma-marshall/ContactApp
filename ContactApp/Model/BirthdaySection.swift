//

import Foundation

struct BirthdaySection {
    let title: String
    let contacts: [Contact]
}

extension BirthdaySection: Identifiable {
    var id: String { return title }
}
