//

import UIKit
import ContactsUI
import SwiftUI

struct CNContactViewControllerAdapter: UIViewControllerRepresentable {
    let contact: CNContact
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = CNContactViewController(for: contact)
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
