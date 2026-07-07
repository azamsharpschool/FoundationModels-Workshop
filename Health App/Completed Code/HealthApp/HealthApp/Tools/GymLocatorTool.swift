import Foundation
import FoundationModels
import MapKit

struct GymLocatorTool: Tool {
    
    let name = "findNearbyGyms"
    let description = """
    Finds nearby gyms, fitness centers, or workout locations.
    """
    
    @Generable
    struct Arguments {
        @Guide(description: "The number of gyms to return.", .range(1...3))
        let limit: Int
    }
    
    func call(arguments: Arguments) async throws -> some PromptRepresentable {
        
        print("GymLocatorTool Called")
        
        let coordinate = CLLocationCoordinate2D(
            latitude: 29.7604,
            longitude: -95.3698
        )
        
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 5_000,
            longitudinalMeters: 5_000
        )
        
        let request = MKLocalSearch.Request(
            naturalLanguageQuery: "gym fitness center",
            region: region
        )
        
        request.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        
        let gyms = response.mapItems
            .prefix(arguments.limit)
            .map { item in
                let coordinate = item.coordinate
                
                return Gym(
                    name: item.name ?? "Unknown gym",
                    address: item.formattedAddress,
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude
                )
            }
        
        return """
        Nearby Gyms:
        
        \(gyms)
        """
    }
}

private extension MKMapItem {
    nonisolated var coordinate: CLLocationCoordinate2D {
        if #available(iOS 26.0, *) {
            location.coordinate
        } else {
            placemark.coordinate
        }
    }
    
    nonisolated var formattedAddress: String {
        if #available(iOS 26.0, *) {
            addressRepresentations?.fullAddress(includingRegion: false, singleLine: true)
            ?? address?.fullAddress
            ?? "Address unavailable"
        } else {
            placemark.title ?? "Address unavailable"
        }
    }
}
