//

import UIKit
import ContactsUI
import SwiftUI

struct CNNewContactViewControllerAdapter: UIViewControllerRepresentable {
    let contact: CNContact
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = CNContactViewController(forUnknownContact: contact)
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
