//
//  HealthApp_ToolsApp.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import SwiftUI
import FoundationModels

enum Instructions {
    static var healthAssistant: String {
        """
        You are a helpful health and wellness assistant.

        Answer only health and fitness questions.

        Use healthSummaryTool only when the user asks about their personal health data.
        Use findNearbyGyms only when the user explicitly asks for nearby gyms or fitness centers.

        Never invent health data or gym locations.

        Keep responses concise and practical.
        """
    }
}

@main
struct HealthAppApp: App {

    let assistantSession: LanguageModelSession
    
    @State private var healthAssistantEngine: HealthAssistantEngine

    init() {
        
        let healthSummaryTool = HealthSummaryTool(healthKitClient: HealthKitClient())
        let gymLocatorTool = GymLocatorTool()
        
        assistantSession = LanguageModelSession(tools: [healthSummaryTool, gymLocatorTool], instructions: Instructions.healthAssistant)
        healthAssistantEngine = HealthAssistantEngine(session: assistantSession)
    }

    var body: some Scene {
        WindowGroup {
            HealthAssistantScreen()
                .environment(healthAssistantEngine)
        }
    }
}
