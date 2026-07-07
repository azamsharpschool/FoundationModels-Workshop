//
//  HealthTool.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import Foundation
import FoundationModels

struct HealthSummaryTool: Tool {

    let healthKitClient: HealthKitClient

    let name = "healthSummaryTool"
    let description = "Retrieves a summary of the user's recent HealthKit data."
    
    @Generable
    struct Arguments {

        @Guide(description: "The number of days of health data to summarize. If omitted, use 7 days.")
        let days: Int
    }

    func call(arguments: Arguments) async throws -> String {
        
        print(arguments.days)
        print("HealthSummaryTool Called")
        
        // connect with HealthKit and return data
        let summary = try await healthKitClient.summary(forLast: arguments.days)
        
        return """
        Health Summary

        Summary Period
        - Days: \(summary.days)

        Activity
        - Average steps per day: \(summary.averageSteps)
        - Average distance per day: \(String(format: "%.1f", summary.averageDistance)) miles
        - Average active calories per day: \(summary.averageActiveCalories)
        - Total workouts: \(summary.workouts)
        - Average exercise minutes per day: \(summary.averageExerciseMinutes)
        - Average stand hours per day: \(String(format: "%.1f", summary.averageStandHours))

        Sleep
        - Average sleep per night: \(String(format: "%.1f", summary.averageSleep)) hours

        Heart Health
        - Average resting heart rate: \(summary.restingHeartRate) bpm
        - Average heart rate variability: \(String(format: "%.1f", summary.heartRateVariability)) ms
        """
        
    }
}
