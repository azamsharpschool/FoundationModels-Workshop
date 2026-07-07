//
//  Gym.swift
//  HealthApp
//
//  Created by Mohammad Azam on 7/7/26.
//

import Foundation
import FoundationModels
import MapKit

@Generable(description: "A gym, fitness center, or workout location returned by a local search.")
struct Gym {

    let name: String
    
    let address: String

    let latitude: Double

    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}
