//
//  HomeView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var searchText = ""
    @State private var placeHolder = "Lost? Just Search!"
    @Binding var selectedTab: Int  // Add this binding
    
    var body: some View {
        // Removed NavigationView since it's handled by MainTabView
        ScrollView {
            VStack(spacing: 10) {
                SearchBar(text: $searchText, placeholder: placeHolder)
                    .padding(.horizontal)
                
                Image("students_banner")
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Features")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    FeaturesGridView(
                        features: viewModel.features,
                        selectedFeature: $viewModel.selectedFeature,
                        selectedTab: $selectedTab  // Pass the binding
                    )
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}

// Add an initializer to handle cases where no binding is provided
extension HomeView {
    init() {
        // This creates a dummy binding for previews or when used without binding
        self._selectedTab = .constant(0)
    }
}
