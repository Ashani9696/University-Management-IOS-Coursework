//
//  FeaturesGridView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

struct FeaturesGridView: View {
    let features: [Feature]
    @Binding var selectedFeature: String?
    @Binding var selectedTab: Int
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(features) { feature in
                FeatureCard(feature: feature, selectedFeature: $selectedFeature, selectedTab: $selectedTab)
            }
        }
    }
}
