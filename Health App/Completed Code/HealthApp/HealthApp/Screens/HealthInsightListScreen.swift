//
//  ContentView.swift
//  HealthApp-Tools
//
//  Created by Mohammad Azam on 7/2/26.
//

import SwiftUI

struct HealthInsightListScreen: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        Button("Generate Insights") {
            isPresented = true
        }.sheet(isPresented: $isPresented) {
            GenerateHealthInsightScreen()
        }
    }
}

#Preview {
    HealthInsightListScreen()
}
