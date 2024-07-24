//
//  ContentView.swift
//  Sprint4
//
//  Created by Alex Jumbo on 22/5/24.
//
import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    @State private var showingAddUserView = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Sprint 4")
                    .font(.title)
                    .padding(.top)
                Text("Agrega contactos y pulsa sobre cada uno para ver su información")
                    .font(.title2)
                    .padding(20)
                List(users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)

                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(InsetGroupedListStyle())

                Spacer()

                Button(action: {
                    showingAddUserView = true
                }) {
                    Text("Más")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddUserView) {
                AddUserView(users: $users)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
