//
//  BookingFormView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-27.
//

import Foundation
import SwiftUI

struct BookingFormView: View {
    @ObservedObject var viewModel: ParkingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Parking image
            Image(viewModel.currentBooking.parkingSlot.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            Text("Get your slot. Hurry up...!")
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Student ID")
                    .font(.system(size: 14, weight: .medium))
                
                TextField("Enter your university id", text: $viewModel.currentBooking.studentId)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Text("Vehicle Type")
                    .font(.system(size: 14, weight: .medium))
                    .padding(.top, 10)
                
                TextField("Enter your vehicle type", text: $viewModel.currentBooking.vehicleType)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Text("Vehicle Number")
                    .font(.system(size: 14, weight: .medium))
                    .padding(.top, 10)
                
                TextField("Enter your vehicle number", text: $viewModel.currentBooking.vehicleNumber)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Confirm booking button
            Button(action: {
                viewModel.confirmBooking()
            }) {
                Text("Confirm Booking")
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
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.alertMessage.contains("confirmed") ? "Success" : "Error"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK")) {
                    if viewModel.alertMessage.contains("confirmed") {
                        viewModel.resetNavigation()
                    }
                }
            )
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
