//
//  ParkingDetailView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-27.
//

import Foundation
import SwiftUI

struct ParkingDetailView: View {
    @ObservedObject var viewModel: ParkingViewModel
    
    // Use a computed property to ensure we always have the latest data
    var slot: ParkingSlot {
        // Get the latest version of the slot from the viewModel.parkingSlots array
        if let selectedSlot = viewModel.selectedParkingSlot,
           let updatedSlot = viewModel.parkingSlots.first(where: { $0.id == selectedSlot.id }) {
            return updatedSlot
        }
        // Fallback to the selected slot if we can't find it in the array
        return viewModel.selectedParkingSlot ?? viewModel.currentBooking.parkingSlot
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(slot.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            // Parking details
            Text("Details of the parking slot \(slot.name.lowercased().replacingOccurrences(of: "parking slot ", with: "")) (\(slot.location.lowercased())).")
                .font(.system(size: 14))
                .padding(.horizontal)
            
            // Vehicle availability
            VStack(alignment: .leading, spacing: 8) {
                ForEach(slot.vehicleSlots) { vehicleSlot in
                    HStack {
                        Text("Available")
                            .foregroundColor(.blue)
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                        
                        Text(vehicleSlot.vehicleType.rawValue)
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text(vehicleSlot.availabilityText)
                            .font(.system(size: 14))
                    }
                }
                
                Text("Get your slot. Hurry up...!")
                    .font(.system(size: 14))
                    .padding(.top, 4)
            }
            .padding()
            
            Spacer()
            
            // Next button - Show booking sheet
            Button(action: {
                viewModel.showBookingSheet()
            }) {
                Text("Next")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle("Book Parking")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // More options
                }) {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowingBookingSheet) {
            BookingSheetView(viewModel: viewModel)
        }
    }
}
