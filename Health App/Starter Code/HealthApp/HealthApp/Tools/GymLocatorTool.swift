import Foundation
import FoundationModels
import MapKit


struct GymLocatorTool {
    // TODO 
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
