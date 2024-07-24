//
//  DetailView.swift
//  Sprint4
//
//  Created by Alex Jumbo on 7/7/24.
//

import SwiftUI
import CoreLocation

struct UserDetailView: View {
    var user: User
    @State private var showingMapView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Información del contacto")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Nombre: \(user.name)")
                Text("Color Preferido: \(user.favoriteColor)")
                Text("Fecha de Nacimiento: \(user.birthDate, formatter: dateFormatter)")
                Text("Ciudad Favorita: \(user.favoriteCity)")
                Text("Número Favorito: \(user.favoriteNumber)")
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .padding(.bottom, 20)
            
            if user.location != nil {
                Button(action: {
                    showingMapView = true
                }) {
                    HStack {
                        Spacer()
                        Text("Ver ciudad favorita")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .sheet(isPresented: $showingMapView) {
                    MapView(city: user.favoriteCity)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Información del contacto", displayMode: .inline)
    }
}

private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User(name: "Test", favoriteColor: "Rojo", birthDate: Date(), favoriteCity: "Madrid", favoriteNumber: "", location: CLLocation(latitude: 12.345346, longitude: -2.346445)))
    }
}

