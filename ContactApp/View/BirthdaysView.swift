//

import SwiftUI

struct BirthdaysView: View {
    @State var birthdays: [BirthdaySection]
    
    var body: some View {
        List {
            ForEach(birthdays) { birthday in
                Section(header: Text(birthday.title)) {
                    ForEach(birthday.contacts) { contact in
                        Text(contact.fullName())
                    }
                }.textCase(.none)
                .font(.system(size: 16))
            }
        }.navigationTitle("Birthdays")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(GroupedListStyle())
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BirthdaysView(birthdays: TestData.testBirthdayData())
        }
    }
}
