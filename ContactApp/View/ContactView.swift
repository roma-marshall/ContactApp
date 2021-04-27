//

import SwiftUI

struct ContactView: View {
    let title: String
    @State var contact: Contact
    
    var body: some View {
        List {
            Text(contact.firstName)
            Text(contact.lastName)
            if contact.phones.count > 0 {
                Text(contact.phones.joined(separator: ", "))
            }
        }.navigationTitle(contact.firstName + " " + contact.lastName)
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactView(title: "Test View", contact: TestData.contacts()[0])
        }
    }
}
