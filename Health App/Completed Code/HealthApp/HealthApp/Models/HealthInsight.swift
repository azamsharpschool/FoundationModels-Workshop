//
//  HealthInsight.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import Foundation
import FoundationModels

@Generable(description: "A personalized health insight generated from the user's recent health data.")
struct HealthInsight {

    @Guide(description: "A short title summarizing the user's recent health activity.")
    let title: String

    @Guide(description: "A friendly summary of the user's recent health trends based on the available health data.")
    let summary: String

    @Guide(description: "Positive observations about the user's recent health habits.")
    let highlights: [String]

    @Guide(description: "Actionable suggestions to help the user improve their health or maintain healthy habits.")
    let recommendations: [String]
}
