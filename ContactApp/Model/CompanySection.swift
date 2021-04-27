//

import Foundation

struct CompanySection {
    let title: String
    let contacts: [Contact]
}

extension CompanySection: Identifiable {
    var id: String { return title }
}
