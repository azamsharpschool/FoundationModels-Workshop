//
//  Untitled.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import Foundation

struct HealthKitClient {

    func summary(forLast days: Int = 7) async throws -> HealthSummary {

        // Query HealthKit

        HealthSummary(
            days: days,
            averageSteps: Int.random(in: 6_000...10_000),
            averageSleep: Double.random(in: 6.5...8.5),
            averageActiveCalories: Int.random(in: 450...800),
            workouts: Int.random(in: max(0, days / 7)...days)
        )
    }

}
