//
//  AppStateManager.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI
import Combine

class AppStateManager: ObservableObject {
    @Published var selectedFeature: String?
    @Published var selectedTab: Int = 0
    @Published var navigationPath = NavigationPath()
    
    @Published var parkingData: [String: Any] = [:]
    @Published var userProfile: [String: Any] = [:]
    
    static let shared = AppStateManager()
    
    private init() {}
    
    func updateSelectedFeature(_ feature: String) {
        selectedFeature = feature
    }
    
    func updateSelectedTab(_ tab: Int) {
        selectedTab = tab
    }
    
    func resetNavigation() {
        navigationPath = NavigationPath()
    }
}
