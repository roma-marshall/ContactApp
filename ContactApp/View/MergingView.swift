//

import SwiftUI
import ContactsUI

struct MergingView: View {
    @Environment(\.presentationMode) var presentationMode
    let selectedContact = ValueContainer<Contact>()
    let newContact = ValueContainer<CNContact>()
    @State var duplicate: Duplicate
    @State private var showContactDetails: Bool = false
    @State private var showNewContactDetails: Bool = false
    @State private var showingAlert = false
    var body: some View {
        VStack {
            List {
                Section(header: Text("Merge Result (Preview)")) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(duplicate.value).bold()
                            Text("Local")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                            Text("New Contact")
                                .foregroundColor(.red)
                                .font(.system(size: 12))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(Font.title.weight(.semibold))
                            .frame(width: 12, height: 12, alignment: .center)
                            .foregroundColor(Color(.systemGray3))

                    }.onTapGesture {
                        self.newContact.content = duplicate.mergedContact()
                        showNewContactDetails.toggle()
                    }.sheet(isPresented: $showNewContactDetails, content: {
                        if let contact = newContact.content {
                            NavigationView {
                                CNNewContactViewControllerAdapter(contact: contact)
                            }
                        }
                    })
                }
                Section(header: Text("Duplicates (Will Be Deleted)")) {
                    ForEach(duplicate.contacts) { contact in
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .font(.title2)
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text(contact.fullName()).bold()
                                Text("Local")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                Text(contact.phones.joined(separator: ", "))
                                    .foregroundColor(.red)
                                    .font(.system(size: 12))
                            }
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
                        }.sheet(isPresented: $showContactDetails, content: {
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
            }
            .navigationTitle("Contacts Merging")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(GroupedListStyle())
            
            Button("Merge", action: {
                showingAlert = true
                
            }).alert(isPresented:$showingAlert) {
                Alert(
                    title: Text("Alert!"),
                    message: Text("Do you really want to merge selected contacts in one contact?"),
                    primaryButton: .destructive(Text("YES")) {
                        try? duplicate.merge()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
            
        }
    }
}

struct MergingViewCell: View {
    let title: String
    let subtitle1: String
    let subtitle2: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color(.systemBlue))
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16))
                Text(subtitle1)
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))
                Text(subtitle2)
                    .font(.system(size: 10))
                    .foregroundColor(.red)
            }
            Spacer()
        }
    }
}

struct MergingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MergingView(duplicate: Duplicate(value: "test", contacts: [Contact]()))
        }
    }
}
