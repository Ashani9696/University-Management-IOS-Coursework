//
//  CustomTabBar.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                Spacer()
                TabBarButton(
                    imageName: getImageName(for: index),
                    title: getTitle(for: index),
                    isSelected: selectedTab == index,
                    action: {
                        selectedTab = index
                    }
                )
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.systemGray5))
                .padding(.bottom, 49),
            alignment: .top
        )
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func getImageName(for tab: Int) -> String {
        switch tab {
        case 0: return "house.fill"
        case 1: return "p.square.fill"
        case 2: return "flask.fill"
        case 3: return "person.fill"
        default: return "house.fill"
        }
    }
    
    private func getTitle(for tab: Int) -> String {
        switch tab {
        case 0: return "Home"
        case 1: return "Parking"
        case 2: return "Labs"
        case 3: return "Profile"
        default: return "Home"
        }
    }
}
