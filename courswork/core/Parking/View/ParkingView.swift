//
//  ParkingView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

struct ParkingView: View {
    @StateObject private var viewModel = ParkingViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack(spacing: 16) {
                // Search bar
                SearchBar(text: $viewModel.searchText, placeholder: "Parking area slots")
                    .padding(.horizontal)
                
                // Parking slots list
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredSlots) { slot in
                            ParkingSlotCard(slot: slot) {
                                viewModel.selectParkingSlot(slot)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: String.self) { route in
                switch route {
                case "details":
                    if viewModel.selectedParkingSlot != nil {
                        ParkingDetailView(viewModel: viewModel)
                    }
                case "booking":
                    BookingFormView(viewModel: viewModel)
                default:
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // More options
                    }) {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
}
