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

    @Guide(description: "A list of nearby gyms. If the user did not explicitly ask for gyms, you MUST return empty array for this field.")
    let gyms: [Gym]
}

@Observable
class HealthAssistantEngine {
    
    let session: LanguageModelSession
    var response: HealthAssistantResponse.PartiallyGenerated?
    
    init(session: LanguageModelSession) {
        self.session = session
    }
    
    func askHealthAssistant(_ question: String) async throws {
        
        response = nil 
        
        let prompt = """
        User question:
        \(question)
        """
        
        let stream = session.streamResponse(to: prompt, generating: HealthAssistantResponse.self)

        for try await partialResponse in stream {
            response = partialResponse.content
        }
    }
    
}
