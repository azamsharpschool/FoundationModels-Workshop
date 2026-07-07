//
//  HealthApp_ToolsApp.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import SwiftUI
import FoundationModels

/*
 Use healthSummaryTool only when the user asks about their personal health data.
 Use findNearbyGyms only when the user explicitly asks for nearby gyms or fitness centers.

 Never invent health data or gym locations.

 */

enum Instructions {
    static var healthAssistant: String {
        """
        You are a helpful health and wellness assistant.

        Answer only health and fitness questions.

        Keep responses concise and practical.
        """
    }
}

@main
struct HealthAppApp: App {

    let assistantSession: LanguageModelSession
    
    @State private var healthAssistantEngine: HealthAssistantEngine

    init() {
        assistantSession = LanguageModelSession(instructions: Instructions.healthAssistant)
        healthAssistantEngine = HealthAssistantEngine(session: assistantSession)
    }

    var body: some Scene {
        WindowGroup {
            HealthAssistantScreen()
                .environment(healthAssistantEngine)
        }
    }
}
