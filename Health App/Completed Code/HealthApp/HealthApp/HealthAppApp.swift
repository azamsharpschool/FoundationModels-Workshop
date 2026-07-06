//
//  HealthApp_ToolsApp.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import SwiftUI
import FoundationModels

enum Instructions {

    static var healthInsightGenerator: String {
        """
        You provide structured health insights using the available tool.

        - Use the `getHealthInsight` tool to retrieve the health insight.
        - Return the tool result as the structured response.
        - Do not make up health metrics.
        - Do not add medical diagnoses or medical advice.
        """
    }
    
    static var healthAssistant: String {
        """
        You are a helpful health and wellness assistant.

        - Answer user questions about activity, workouts, sleep, steps, calories, and general health trends.
        - Use the available health tools when health data is needed.
        - Use the `findNearbyGyms` tool when the user asks for nearby gyms, fitness centers, or workout locations.
        - Do not make up health metrics or gym locations.
        - Explain trends clearly and supportively.
        - Do not diagnose medical conditions or provide medical advice.
        """
    }
}

@main
struct HealthAppApp: App {

    let insightSession: LanguageModelSession
    let assistantSession: LanguageModelSession
    
    @State private var healthInsightEngine: HealthInsightEngine
    @State private var healthAssistantEngine: HealthAssistantEngine

    init() {
        let healthTool = HealthTool(healthKitClient: HealthKitClient())
        let gymLocatorTool = GymLocatorTool()
        
        insightSession = LanguageModelSession(tools: [healthTool], instructions: Instructions.healthInsightGenerator)
        assistantSession = LanguageModelSession(tools: [gymLocatorTool], instructions: Instructions.healthAssistant)
        
        healthInsightEngine = HealthInsightEngine(session: insightSession)
        healthAssistantEngine = HealthAssistantEngine(session: assistantSession)
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    HealthInsightListScreen()
                }
                .tabItem {
                    Label("Insights", systemImage: "heart.text.square")
                }
                .environment(healthInsightEngine)
                  
                NavigationStack {
                    HealthAssistantScreen()
                }
                .tabItem {
                    Label("Assistant", systemImage: "message")
                }
                .environment(healthAssistantEngine)
                 
            }
        }
    }
}
