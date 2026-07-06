//
//  HealthTool.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import Foundation
import FoundationModels

struct HealthTool: Tool {

    let healthKitClient: HealthKitClient

    let name = "getHealthInsight"
    let description = """
    Retrieves the user's recent HealthKit information.

    Use this tool when health data is needed.
    """
    
    @Generable
    struct Arguments {

        @Guide(description: "The number of days of health data to summarize.", .range(1...30))
        let days: Int
    }

    func call(arguments: Arguments) async throws -> HealthInsight {
        print("TOOL CALLED")

        let summary = try await healthKitClient.summary(forLast: arguments.days)

        return HealthInsight(
            title: "Recent Health Activity",
            summary: "For the last \(summary.days) day, you averaged \(summary.averageSteps) steps, \(summary.averageSleep) hours of sleep, \(summary.averageActiveCalories) active calories, and completed \(summary.workouts) workout\(summary.workouts == 1 ? "" : "s").",
            highlights: [
                "You averaged \(summary.averageSteps) steps.",
                "You averaged \(summary.averageSleep) hours of sleep.",
                "You completed \(summary.workouts) workout\(summary.workouts == 1 ? "" : "s")."
            ],
            recommendations: [
                "Keep tracking your activity and rest patterns.",
                "Look for consistency across steps, sleep, and workouts."
            ]
        )
    }
}
