//
//  FeatureCard.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

struct FeatureCard: View {
    let feature: Feature
    @Binding var selectedFeature: String?
    @Binding var selectedTab: Int // Add binding for selected tab
    
    var body: some View {
        Button(action: {
            // Set the selected feature
            selectedFeature = feature.destination
            
            // Change the tab based on destination
            switch feature.destination {
            case "ParkingView":
                selectedTab = 1
            case "LabView": // Assuming this would be your search view
                selectedTab = 2
            case "UserView": // Assuming this would be your user view
                selectedTab = 3
            default:
                selectedTab = 0 // Default to home tab
            }
        }) {
            VStack(spacing: 12) {
                Image(systemName: feature.icon)
                    .font(.system(size: 40))
                    .foregroundColor(selectedFeature == feature.destination ? .white : feature.foregroundColor)
                
                Text(feature.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(selectedFeature == feature.destination ? .white : feature.foregroundColor)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .background(selectedFeature == feature.destination ? Color.blue : feature.backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(feature.borderColor, lineWidth: 1)
            )
        }
    }
}
