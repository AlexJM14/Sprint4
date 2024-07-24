//
//  MapView.swift
//  Sprint4
//
//  Created by Alex Jumbo on 7/7/24.
//
import SwiftUI
import MapKit

struct MapView: View {
    var city: String
    @State private var region = MKCoordinateRegion()

    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear {
                getCoordinates(for: city) { coordinate in
                    if let coordinate = coordinate {
                        region = MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        )
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Mapa", displayMode: .inline)
    }

    func getCoordinates(for city: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                completion(location.coordinate)
            } else {
                completion(nil)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(city: "Madrid")
    }
}
