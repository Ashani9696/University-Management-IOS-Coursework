//
//  RootView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

struct RootView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        MainTabView(selectedTab: $selectedTab) {
            TabView(selection: $selectedTab) {
                HomeView(selectedTab: $selectedTab)  // Pass the binding
                    .tag(0)
                ParkingView()
                    .tag(1)
                LabView()
                    .tag(2)
                Text("User View")
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide the dots
            .animation(.easeInOut, value: selectedTab) // Add smooth transition
            .edgesIgnoringSafeArea(.bottom) // Extend to bottom edge
        }
    }
}
