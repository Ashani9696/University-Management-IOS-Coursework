//
//  MainTabView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

struct MainTabView<Content: View>: View {
    @Binding var selectedTab: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var navPath = NavigationPath()
    let content: Content
    
    init(selectedTab: Binding<Int>, @ViewBuilder content: () -> Content) {
        self._selectedTab = selectedTab
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack(alignment: .bottom) {
                content
                    .padding(.bottom, 50)
                CustomTabBar(selectedTab: $selectedTab)
            }
            .navigationDestination(for: String.self) { destination in
                destinationView(for: destination)
                    .navigationBarBackButtonHidden(false)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if !navPath.isEmpty {
                            navPath.removeLast()
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.left")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(getTitle(for: selectedTab))
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func destinationView(for destination: String) -> some View {
        switch destination {
        case "LocationView":
            Text("Location View")
        case "ParkingView":
            ParkingView()
        case "CafeteriasView":
            Text("Cafeterias View")
        case "LabsView":
            LabView()
        default:
            Text("Unknown View")
        }
    }
    
    private func getTitle(for tab: Int) -> String {
        switch tab {
        case 0: return "Home"
        case 1: return "Parking"
        case 2: return "Find a Lab"
        case 3: return "Profile"
        default: return "Home"
        }
    }
}
