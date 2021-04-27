//

import SwiftUI

struct CompaniesView: View {
    @State var companies: [CompanySection]
    
    var body: some View {
        List {
            ForEach(companies) { company in
                Section(header: Text(company.title)) {
                    ForEach(company.contacts) { contact in
                        Text(contact.fullName())
                    }
                }.textCase(.none)
                .font(.system(size: 16))
            }
        }.navigationTitle("Companies")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(GroupedListStyle())
    }
}

struct CompaniesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CompaniesView(companies: TestData.testCompanyData())
        }
    }
}
