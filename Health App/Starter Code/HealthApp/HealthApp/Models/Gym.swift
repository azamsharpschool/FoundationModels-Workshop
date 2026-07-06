import Foundation
import FoundationModels
import MapKit


@Generable(description: "A gym, fitness center, or workout location returned by a local search.")
struct Gym {

    @Guide(description: "The gym or fitness center name.")
    let name: String

    @Guide(description: "The formatted street address for the gym.")
    let address: String

    @Guide(description: "The latitude coordinate for the gym.")
    let latitude: Double

    @Guide(description: "The longitude coordinate for the gym.")
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            )
        }
}


