//
//  FormView.swift
//  Sprint4
//
//  Created by Alex Jumbo on 7/7/24.
//

import SwiftUI
import CoreLocation

struct AddUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var users: [User]
    @State private var name = ""
    @State private var favoriteColor = ""
    @State private var birthDate = Date()
    @State private var favoriteCity = ""
    @State private var favoriteNumber = ""
    @State private var location: CLLocation?
    @State private var currentCity = "Desconocida"
    @ObservedObject private var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Nombre", text: $name)
                    TextField("Color Preferido", text: $favoriteColor)
                    DatePicker("Fecha de Nacimiento", selection: $birthDate, displayedComponents: .date)
                    TextField("Ciudad Favorita", text: $favoriteCity)
                    TextField("Número Favorito", value: $favoriteNumber, formatter: NumberFormatter())
                }

                Section {
                    Button(action: {
                        getCurrentLocation()
                    }) {
                        HStack {
                            Image(systemName: "location.fill")
                            Text("Calcular ubicación actual")
                        }
                    }
                    
                    HStack {
                        Text("Ciudad Actual:")
                        Spacer()
                        Text(currentCity)
                            .foregroundColor(.gray)
                    }
                }

                Section {
                    Button(action: {
                        let newUser = User(name: name, favoriteColor: favoriteColor, birthDate: birthDate, favoriteCity: favoriteCity, favoriteNumber: favoriteNumber, location: location)
                        users.append(newUser)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Spacer()
                            Text("Guardar")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                    }
                }
            }
            .navigationBarTitle("Añadir Usuario", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancelar") {
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                getCurrentLocation()
            }
        }
    }
    
    func getCurrentLocation() {
        if let currentLocation = locationManager.location {
            location = currentLocation
            fetchCityAndCountry(from: currentLocation) { city, country, error in
                if let city = city, let country = country, error == nil {
                    self.currentCity = "\(city), \(country)"
                } else {
                    self.currentCity = "Desconocida"
                }
            }
        }
    }

    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(
                placemarks?.first?.locality,
                placemarks?.first?.country,
                error
            )
        }
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView(users: .constant([]))
    }
}
