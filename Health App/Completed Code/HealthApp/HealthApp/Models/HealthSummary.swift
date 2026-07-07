//
//  HealthSummary.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import Foundation

struct HealthSummary {

    /// The number of days included in the summary.
    let days: Int

    /// The average number of steps taken per day.
    let averageSteps: Int

    /// The average number of hours slept per night.
    let averageSleep: Double

    /// The average number of active calories burned per day.
    let averageActiveCalories: Int

    /// The total number of workouts completed during the summary period.
    let workouts: Int

    /// The average distance walked or run per day in miles.
    let averageDistance: Double

    /// The average exercise time per day in minutes.
    let averageExerciseMinutes: Int

    /// The average amount of time spent standing per day in hours.
    let averageStandHours: Double

    /// The average resting heart rate in beats per minute.
    let restingHeartRate: Int

    /// The average heart rate variability in milliseconds.
    let heartRateVariability: Double
}
