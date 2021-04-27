//

import SwiftUI
import ContactsUI

struct ContactsListView: View {
    let title: String
    let titleType: TitleType
    let selectedContact = ValueContainer<Contact>()
    @State var contacts: [Contact]
    @State private var searchText: String = ""
    @State private var showContactDetails: Bool = false
    
    var body: some View {
        let filteredContacts: [Contact] = {
            if searchText == "" {
                return contacts
            } else {
                return contacts.filter { $0.fullName().contains(searchText) }
            }
        }()
        
        VStack {
            SearchView(text: $searchText)
            
            List {
                ForEach(filteredContacts) { contact in
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                            .foregroundColor(.blue)
                        Text(contact.title(for: titleType))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(Font.title.weight(.semibold))
                            .frame(width: 12, height: 12, alignment: .center)
                            .foregroundColor(Color(.systemGray3))
                    }.onTapGesture {
                        selectedContact.content = contact
                        showContactDetails.toggle()
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(GroupedListStyle())
        }
        .sheet(isPresented: $showContactDetails, content: {
            if let contact = selectedContact.content {
                let contactInCB = try? CNContactStore().unifiedContact(
                    withIdentifier: contact.id,
                    keysToFetch: [CNContactViewController.descriptorForRequiredKeys()]
                )
                if let contactCB = contactInCB {
                    NavigationView {
                        CNContactViewControllerAdapter(contact: contactCB)
                    }
                }
            }
        })
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsListView(title: "Test View", titleType: .name, contacts: TestData.contacts())
        }
    }
}

extension ContactsListView {
    enum TitleType {
        case name
        case phone
    }
}

extension Contact {
    func title(for type: ContactsListView.TitleType) -> String {
        switch type {
        case .name: return fullName()
        case .phone: return phones.joined(separator: ", ")
        }
    }
}
