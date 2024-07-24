//
//  Contact.swift
//  Sprint4
//
//  Created by Alex Jumbo on 24/5/24.
//

import Foundation
import CoreLocation

struct User: Identifiable {
    var id = UUID()
    var name: String
    var favoriteColor: String
    var birthDate: Date
    var favoriteCity: String
    var favoriteNumber: String
    var location: CLLocation?
}

