//
//  Untitled.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import Foundation

struct HealthKitClient {

    func summary(forLast days: Int = 7) async throws -> HealthSummary {

        // Query HealthKit and get the data 

        HealthSummary(
            days: days,
            averageSteps: Int.random(in: 6_000...10_000),
            averageSleep: Double.random(in: 6.5...8.5),
            averageActiveCalories: Int.random(in: 450...800),
            workouts: Int.random(in: max(0, days / 7)...days),
            averageDistance: Double.random(in: 2.5...6.5),
            averageExerciseMinutes: Int.random(in: 20...60),
            averageStandHours: Double.random(in: 8.0...14.0),
            restingHeartRate: Int.random(in: 52...72),
            heartRateVariability: Double.random(in: 35.0...75.0)
        )
    }

}
