//
//  HealthAssistantEngine.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/3/26.
//

import Foundation
import Observation
import FoundationModels

@Generable(description: "The assistant's response to the user's health-related question.")
struct HealthAssistantResponse {

    @Guide(description: "A helpful natural language response that answers the user's question.")
    let text: String

    @Guide(description: "A list of nearby gyms or fitness centers. Populate this only if the user asked for nearby gyms or workout locations. Otherwise, return an empty array.")
    let gyms: [Gym]
}

@Observable
class HealthAssistantEngine {
    
    let session: LanguageModelSession
    var responseText = ""
    var response: HealthAssistantResponse.PartiallyGenerated?
    
    init(session: LanguageModelSession) {
        self.session = session
    }
    
    func askHealthAssistant(_ question: String) async throws {
        
        /*
        responseText = ""

        let prompt = """
        Answer the user's health question using this health summary.

        Health summary for the last \(summary.days) days:
        - Average steps: \(summary.averageSteps)
        - Average sleep: \(summary.averageSleep) hours
        - Average active calories: \(summary.averageActiveCalories)
        - Workouts: \(summary.workouts)

        User question:
        \(question)
        """ */

        let stream = session.streamResponse(to: question, generating: HealthAssistantResponse.self)

        for try await partialResponse in stream {
            response = partialResponse.content
        }
    }
    
}
