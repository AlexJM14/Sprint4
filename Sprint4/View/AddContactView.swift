//
//  AddContactView.swift
//  Sprint4
//
//  Created by Alex Jumbo on 24/5/24.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var contact: ContactViewModel
    
    @State private var name = ""
    @State private var favoriteNumber = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Agrega un nuevo contacto")) {
                    TextField("Nombre", text: $name)
                    TextField("Teléfono", text: $favoriteNumber)
                }
            }
            .navigationBarTitle("Nuevo contacto")
            .navigationBarItems(trailing:
                Button(action: addContact) {
                    Text("Guardar")
                }
            )
        }
    }
    
    func addContact() {
        contact.addContact(name: name, phone: favoriteNumber)
        presentationMode.wrappedValue.dismiss()
    }
}


#Preview {
    AddContactView( contact: ContactViewModel())
}
