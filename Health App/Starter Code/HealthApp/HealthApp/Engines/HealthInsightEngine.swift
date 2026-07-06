//
//  HealthInsightEngine.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import Foundation
import FoundationModels
import Observation

@Observable
class HealthInsightEngine {

    let session: LanguageModelSession
    var healthInsight: HealthInsight.PartiallyGenerated?

    init(session: LanguageModelSession) {
        self.session = session
    }

    func generateHealthInsight() async throws {
        let prompt = """
        Generate a friendly health insight.

        First call the getHealthInsight tool.
        Then use only the tool result to generate the insight.
        """

        let stream = session.streamResponse(to: prompt, generating: HealthInsight.self)
        for try await partialResponse in stream {
            healthInsight = partialResponse.content
        }
    }
}
