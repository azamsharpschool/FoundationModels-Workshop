//
//  GenerateHealthInsightScreen.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import SwiftUI

struct GenerateHealthInsightScreen: View {

    @Environment(\.healthKitClient) private var healthkitClient
    @Environment(HealthInsightEngine.self) private var healthInsightEngine

    @State private var errorMessage: String?
    @State private var isGenerating = false
    @State private var healthSummary: HealthSummary?

    var body: some View {
        NavigationStack {
            Group {
                if let healthInsight = healthInsightEngine.healthInsight {
                    List {
                        
                        if let healthSummary {
                            Section("Health Summary") {
                                LabeledContent("Days", value: "\(healthSummary.days)")
                                LabeledContent("Average steps", value: "\(healthSummary.averageSteps)")
                                LabeledContent("Average sleep", value: "\(healthSummary.averageSleep) hours")
                                LabeledContent("Average active calories", value: "\(healthSummary.averageActiveCalories)")
                                LabeledContent("Workouts", value: "\(healthSummary.workouts)")
                            }
                        }
                        
                        Section("Insight") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(healthInsight.title ?? "Generating title...")
                                    .font(.headline)

                                Text(healthInsight.summary ?? "Generating summary...")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }

                        if let highlights = healthInsight.highlights, !highlights.isEmpty {
                            Section("Highlights") {
                                ForEach(highlights, id: \.self) { highlight in
                                    Label(highlight, systemImage: "checkmark.circle")
                                }
                            }
                        }

                        if let recommendations = healthInsight.recommendations, !recommendations.isEmpty {
                            Section("Recommendations") {
                                ForEach(recommendations, id: \.self) { recommendation in
                                    Label(recommendation, systemImage: "lightbulb")
                                }
                            }
                        }

                        if isGenerating {
                            Section {
                                HStack {
                                    ProgressView()
                                    Text("Generating insight...")
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                } else if isGenerating {
                    ProgressView("Generating health insight...")
                } else if let errorMessage {
                    ContentUnavailableView(
                        "Unable to Generate Insight",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                } else {
                    ContentUnavailableView(
                        "No Health Insight",
                        systemImage: "heart.text.square",
                        description: Text("Generate an insight to review your recent health activity.")
                    )
                }
            }
            .navigationTitle("Health Insight")
            .toolbar {
                Button("Refresh") {
                    Task {
                        await generateHealthInsight()
                    }
                }
                .disabled(isGenerating)
            }
            .task {
                await generateHealthInsight()
            }
        }
    }

    private func generateHealthInsight() async {
        isGenerating = true
        errorMessage = nil
        healthInsightEngine.healthInsight = nil

        do {
            try await healthInsightEngine.generateHealthInsight()
        } catch {
            errorMessage = error.localizedDescription
        }

        isGenerating = false
    }
}
