//
//  LabItemView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-28.
//

import Foundation
import SwiftUI

struct LabItemView: View {
    let lab: Lab
    let viewModel: LabViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(lab.name)
                    .font(.headline)
                
                Text(lab.timeRangeFormatted)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                viewModel.selectLab(lab)
            } label: {
                Text("Book")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(lab.isAvailable ? Color.blue : Color.gray)
                    .cornerRadius(20)
            }
            .disabled(!lab.isAvailable)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
