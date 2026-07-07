import SwiftUI
import MapKit

struct HealthAssistantScreen: View {

    @Environment(\.healthKitClient) private var healthKitClient
    @Environment(HealthAssistantEngine.self) private var healthAssistantEngine

    @State private var prompt = "How many calories burned?"
    @State private var healthSummary: HealthSummary?
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            if let response = healthAssistantEngine.response {
                Label("Health Assistant", systemImage: "sparkles")
                       .font(.caption)
                       .foregroundStyle(.secondary)

                   Text(response.text ?? "")
                       .frame(maxWidth: .infinity, alignment: .leading)
                
                if let gyms = response.gyms, !gyms.isEmpty {
                    GymMapView(gyms: gyms)
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay(alignment: .center, content: {
            if isLoading {
                ProgressView("Loading...")
            }
        })
        .safeAreaInset(edge: .bottom) {
            HStack {
                TextField("Enter prompt", text: $prompt)
                
                Button("Submit") {
                    Task {
                        do {
                            isLoading = true
                            //let summary = try await healthKitClient.summary()
                            try await healthAssistantEngine.askHealthAssistant(
                                prompt
                            )
                            
                            isLoading = false
                            
                        } catch {
                            isLoading = false
                            print(error.localizedDescription)
                        }
                        
                        prompt = ""
                    }
                }.disabled(isLoading)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            .background(.bar)
        }
    }

 
  
}

private struct GymMapView: View {

    let gyms: [Gym.PartiallyGenerated]

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 29.7604, longitude: -95.3698),
            latitudinalMeters: 5_000,
            longitudinalMeters: 5_000
        )
    )

    var body: some View {
        Map(position: $position) {
            ForEach(Array(gyms.enumerated()), id: \.offset) { _, gym in
                if let coordinate = gym.coordinate {
                    Marker(gym.name ?? "", coordinate: coordinate)
                }
            }
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private extension Gym.PartiallyGenerated {
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude, let longitude else {
            return nil
        }

        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
