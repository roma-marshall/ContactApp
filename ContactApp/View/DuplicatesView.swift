//

import SwiftUI

struct DuplicatesView: View {
    let title: String
    @State var selectedDuplicate: Duplicate?
    @State var duplicates: [Duplicate]
    @State private var showingSheet = false
    @State private var pushingNewView = false
    
    var body: some View {
        VStack {
            List {
                ForEach(duplicates) { duplicate in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .font(.title2)
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text(duplicate.value).bold()
                                Text(duplicate.listDescription())
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.semibold))
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(Color(.systemGray3))
                        }
                    }.onTapGesture {
                        selectedDuplicate = duplicate
                        showingSheet.toggle()
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(GroupedListStyle())
            .actionSheet(isPresented: $showingSheet, content: {
                ActionSheet(
                    title: Text("Do you want to merge contacts?"),
                    message: Text("Merging Contact"),
                    buttons: [
                        .default(Text("Merge")) {
                            pushingNewView.toggle()
                        },
                        .cancel(Text("Cancel"))
                    ]
                )
            })
            
            // hidden navigation link to be able to push view to navigation controller
            NavigationLink(
                destination: MergingView(
                    duplicate: selectedDuplicate ?? Duplicate(
                        value: "",
                        contacts: [Contact]()
                    )
                ),
                isActive: $pushingNewView,
                label: {
                    EmptyView()
                }
            ).allowsHitTesting(false)
            .hidden()
        }
    }
}

struct DuplicatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DuplicatesView(title: "Test View", duplicates: TestData.nameDuplicates())
        }
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(GroupedListStyle())
    }
}


extension Duplicate {
    public func listDescription() -> String {
        return contacts
            .map{
                $0.firstName + " " + $0.lastName
            }
            .joined(separator: ", ")
    }
}
