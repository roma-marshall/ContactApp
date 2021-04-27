//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        isEditing = true
                    }
                if isEditing {
                    Button(action: {
                        isEditing = false
                        text = ""
                        hideKeyboard()
                    }
                    ) {
                        Text("Cancel")
                    }.foregroundColor(.white)
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
        }.padding(.top, 8)
        .padding(.bottom, 8)
        .background(Color(.systemBlue))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchView(text: .constant(""))
            Spacer()
        }
    }
}
