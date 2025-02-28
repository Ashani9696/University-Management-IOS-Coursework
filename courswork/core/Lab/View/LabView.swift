//
//  LabView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-28.
//

import Foundation
import SwiftUI

// Main view for finding and selecting labs
struct LabView: View {
    @StateObject private var viewModel = LabViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack(spacing: 0) {
                
                SearchBar(text: $viewModel.searchText, placeholder: "Find your laboratories")
                    .padding(.horizontal)
                
                // Lab list section
                Text("Select your Lab")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.filteredLabs) { lab in
                            LabItemView(lab: lab, viewModel: viewModel)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
            }
            .navigationDestination(for: String.self) { route in
                if route == "details" {
                    if let selectedLab = viewModel.selectedLab {
                        LabDetailView(lab: selectedLab, viewModel: viewModel)
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(viewModel.alertTitle),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
