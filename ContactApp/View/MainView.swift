//

import SwiftUI

struct MainView: View {
    private let manager = ContactsManager()
    @State var allContacts = [Contact]()
    @State var duplicateNames = [Duplicate]()
    @State var duplicatePhones = [Duplicate]()
    @State var duplicateEmails = [Duplicate]()
    @State var noName = [Contact]()
    @State var noPhone = [Contact]()
    @State var noData = [Contact]()
    @State var birthday = [BirthdaySection]()
    @State var company = [CompanySection]()
    
    var body: some View {
        
        NavigationView {
            List {
                Text("General")
                    .listRowBackground(Color(#colorLiteral(red: 0.9685322642, green: 0.9686941504, blue: 0.9685109258, alpha: 1)))
                    .foregroundColor(Color(#colorLiteral(red: 0.4587756991, green: 0.4588568807, blue: 0.4587649703, alpha: 1)))
                NavigationLink(
                    destination: ContactsListView(title: "All Contacts", titleType: .name, contacts: allContacts),
                    label: {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                            .font(.title3)
                            .frame(width: 30, height: 30, alignment: .center)
                        Text("All Contacts").lineLimit(1)
                        Spacer()
                        Text("\(allContacts.count)")
                            .foregroundColor(.gray)
                    }
                )
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(GroupedListStyle())
                
                Group {
                    Text("Duplicates")
                        .listRowBackground(Color(#colorLiteral(red: 0.9685322642, green: 0.9686941504, blue: 0.9685109258, alpha: 1)))
                        .foregroundColor(Color(#colorLiteral(red: 0.4587756991, green: 0.4588568807, blue: 0.4587649703, alpha: 1)))
                    
                    NavigationLink(
                        destination: DuplicatesView(title: "Duplicates Name", duplicates: duplicateNames),
                        label: {
                            Image(systemName: "person.2.fill")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                            Text("Duplicate Names").lineLimit(1)
                            Spacer()
                            Text("\(duplicateNames.count)")
                                .foregroundColor(.gray)
                        }
                    )
                    NavigationLink(
                        destination: DuplicatesView(title: "Duplicates Phones", duplicates: duplicatePhones),
                        label: {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                            Text("Duplicate Phones").lineLimit(1)
                            Spacer()
                            Text("\(duplicatePhones.count)")
                                .foregroundColor(.gray)
                        }
                    )
                    NavigationLink(
                        destination: DuplicatesView(title: "Duplicates Email", duplicates: duplicateEmails),
                        label: {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                            Text("Duplicate Email Address")
                            Spacer()
                            Text("\(duplicateEmails.count)")
                                .foregroundColor(.gray)
                        }
                    )
                    NavigationLink(
                        destination: DuplicatesView(title: "Similar Name", duplicates: duplicateNames),
                        label: {
                            Image(systemName: "person.crop.circle.fill.badge.exclamationmark")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                            Text("Similar Name").lineLimit(1)
                            Spacer()
                            Text("\(duplicateNames.count)")
                                .foregroundColor(.gray)
                        }
                    )
                }
                
                Group {
                    Text("Missing Information")
                        .listRowBackground(Color(#colorLiteral(red: 0.9685322642, green: 0.9686941504, blue: 0.9685109258, alpha: 1)))
                        .foregroundColor(Color(#colorLiteral(red: 0.4587756991, green: 0.4588568807, blue: 0.4587649703, alpha: 1)))
                    
                    NavigationLink(
                        destination: ContactsListView(title: "No Name", titleType: .phone, contacts: noName),
                        label: {
                            Image(systemName: "a.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                            Text("No Name").lineLimit(1)
                            Spacer()
                            Text("\(noName.count)")
                                .foregroundColor(.gray)
                        }
                    )
                    NavigationLink(
                        destination: ContactsListView(title: "No Phone", titleType: .name, contacts: noPhone),
                        label: {
                            Image(systemName: "phone.fill.badge.plus")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                            Text("No Phone").lineLimit(1)
                            Spacer()
                            Text("\(noPhone.count)")
                                .foregroundColor(.gray)
                        }
                    )
                    NavigationLink(
                        destination: ContactsListView(title: "No Phones & No Emails", titleType: .name, contacts: noData),
                        label: {
                            Image(systemName: "xmark.bin.fill")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                            Text("No Phone & No Email")
                            Spacer()
                            Text("\(noData.count)")
                                .foregroundColor(.gray)
                        }
                    )
                    
                    Group {
                        Text("Filters")
                            .listRowBackground(Color(#colorLiteral(red: 0.9685322642, green: 0.9686941504, blue: 0.9685109258, alpha: 1)))
                            .foregroundColor(Color(#colorLiteral(red: 0.4587756991, green: 0.4588568807, blue: 0.4587649703, alpha: 1)))
                        
                        NavigationLink(
                            destination: BirthdaysView(birthdays: birthday),
                            label: {
                                Image(systemName: "sparkles")
                                    .foregroundColor(.blue)
                                    .font(.title3)
                                    .frame(width: 30, height: 30, alignment: .center)
                                Text("Birthday").lineLimit(1)
                                Spacer()
                                Text("\(birthday.count)")
                                    .foregroundColor(.gray)
                            }
                        )
                        NavigationLink(
                            destination: CompaniesView(companies: company),
                            label: {
                                Image(systemName: "building.2.fill")
                                    .foregroundColor(.blue)
                                    .font(.title3)
                                    .frame(width: 30, height: 30, alignment: .center)
                                Text("Company").lineLimit(1)
                                Spacer()
                                Text("\(company.count)")
                                    .foregroundColor(.gray)
                            }
                        )
                        NavigationLink(
                            destination: Text("No contacts with the same profession were found"),
                            label: {
                                Image(systemName: "graduationcap.fill")
                                    .foregroundColor(.blue)
                                    .font(.title3)
                                    .frame(width: 30, height: 30, alignment: .center)
                                Text("Profession").lineLimit(1)
                                Spacer()
                                Text("0")
                                    .foregroundColor(.gray)
                            }
                        )
                    }
                    
                }
            }
            .navigationTitle("Contacts")
        }
        .onAppear(perform: refetch)
        
    }
}


extension MainView {
    private func refetch() {
        manager.refetchContacts { (result) in
            switch result {
            case .success(_):
                self.allContacts = self.manager.allContacts
                self.duplicateNames = self.manager.firstNameDuplicates()
                self.duplicatePhones = self.manager.phoneDuplicates()
                self.duplicateEmails = self.manager.emailDuplicates()
                self.noName = self.manager.noName()
                self.noPhone = self.manager.noPhone()
                self.noData = self.manager.noData()
                self.birthday = self.manager.birthday()
                self.company = self.manager.company()
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
