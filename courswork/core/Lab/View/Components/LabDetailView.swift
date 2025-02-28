//
//  LabDetailView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-28.
//

import Foundation
import SwiftUI

struct LabDetailView: View {
    let lab: Lab
    @ObservedObject var viewModel: LabViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Lab information
                VStack(alignment: .leading, spacing: 8) {
                    Text(lab.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(lab.timeRangeFormatted)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    // Capacity information
                    HStack {
                        Image(systemName: "person.3.fill")
                        
                        let capacity = viewModel.maxCapacity[lab.id] ?? 0
                        let booked = viewModel.bookedCapacity[lab.id] ?? 0
                        let available = capacity - booked
                        
                        Text("Capacity: \(available) available of \(capacity)")
                            .foregroundColor(available > 0 ? .primary : .red)
                    }
                    .padding(.top, 4)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                // Book button
                Button {
                    viewModel.showBookingSheet()
                } label: {
                    Text("Book This Lab")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(lab.isAvailable ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!lab.isAvailable)
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle("Lab Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.isShowingBookingSheet) {
            LabBookingFormView(viewModel: viewModel)
        }
    }
}
