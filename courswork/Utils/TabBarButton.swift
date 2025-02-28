//
//  TabBarButton.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-27.
//

import Foundation
import SwiftUI

struct TabBarButton: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: imageName)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? .blue : .gray)
                
                Text(title)
                    .font(.system(size: 11))
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
    }
}
