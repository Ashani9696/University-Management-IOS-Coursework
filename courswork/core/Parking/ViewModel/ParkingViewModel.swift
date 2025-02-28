//
//  ParkingViewModel.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import Foundation
import SwiftUI

class ParkingViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var parkingSlots: [ParkingSlot] = []
    @Published var selectedParkingSlot: ParkingSlot?
    @Published var currentBooking = BookingInfo(parkingSlot: ParkingSlot(name: "", location: "", vehicleSlots: [], isCrowded: false, imageName: ""))
    @Published var navigationPath = NavigationPath()
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var isShowingBookingSheet = false
    
    init() {
        self.parkingSlots = [
            ParkingSlot(
                name: "Parking Slot 1",
                location: "Near by the campus playground",
                vehicleSlots: [
                    VehicleSlot(vehicleType: .car, totalSpaces: 10, bookedSpaces: 5),
                    VehicleSlot(vehicleType: .motorbike, totalSpaces: 25, bookedSpaces: 10),
                    VehicleSlot(vehicleType: .bicycle, totalSpaces: 30, bookedSpaces: 2)
                ],
                isCrowded: true,
                imageName: "parking"
            ),
            ParkingSlot(
                name: "Parking Slot 2",
                location: "Front side of the university",
                vehicleSlots: [
                    VehicleSlot(vehicleType: .car, totalSpaces: 10, bookedSpaces: 10),
                    VehicleSlot(vehicleType: .motorbike, totalSpaces: 25, bookedSpaces: 15),
                    VehicleSlot(vehicleType: .bicycle, totalSpaces: 30, bookedSpaces: 28)
                ],
                isCrowded: true,
                imageName: "parking"
            ),
            ParkingSlot(
                name: "Parking Slot 3",
                location: "Near by the lecturer's car parking",
                vehicleSlots: [
                    VehicleSlot(vehicleType: .car, totalSpaces: 10, bookedSpaces: 5),
                    VehicleSlot(vehicleType: .motorbike, totalSpaces: 25, bookedSpaces: 15),
                    VehicleSlot(vehicleType: .bicycle, totalSpaces: 30, bookedSpaces: 28)
                ],
                isCrowded: true,
                imageName: "parking"
            )
        ]
    }
    
    var filteredSlots: [ParkingSlot] {
        if searchText.isEmpty {
            return parkingSlots
        }
        return parkingSlots.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.location.lowercased().contains(searchText.lowercased())
        }
    }
    
    func selectParkingSlot(_ slot: ParkingSlot) {
        // Find the most up-to-date version of the slot
        if let index = parkingSlots.firstIndex(where: { $0.id == slot.id }) {
            selectedParkingSlot = parkingSlots[index]
            currentBooking = BookingInfo(parkingSlot: parkingSlots[index])
        } else {
            selectedParkingSlot = slot
            currentBooking = BookingInfo(parkingSlot: slot)
        }
        navigationPath.append("details")
    }
    
    func showBookingSheet() {
        print("Opening booking sheet")
        // Reset booking form fields except parkingSlot
        let parkingSlot = currentBooking.parkingSlot
        currentBooking = BookingInfo(parkingSlot: parkingSlot)
        isShowingBookingSheet = true
    }
    
    func confirmBooking() {
        // Check that all fields are filled
        if currentBooking.studentId.isEmpty ||
           currentBooking.vehicleType.isEmpty ||
           currentBooking.vehicleNumber.isEmpty {
            alertMessage = "Please fill in all fields"
            showAlert = true
            return
        }
        
        // Find the parking slot to update
        if let slotIndex = parkingSlots.firstIndex(where: { $0.id == currentBooking.parkingSlot.id }) {
            let vehicleType = getVehicleType(from: currentBooking.vehicleType)
            
            // Find the vehicle slot to update
            if let vehicleSlotIndex = parkingSlots[slotIndex].vehicleSlots.firstIndex(where: { $0.vehicleType == vehicleType }) {
                // Check if the slot is available
                if parkingSlots[slotIndex].vehicleSlots[vehicleSlotIndex].bookedSpaces <
                   parkingSlots[slotIndex].vehicleSlots[vehicleSlotIndex].totalSpaces {
                    
                    // Update the booked spaces count
                    parkingSlots[slotIndex].vehicleSlots[vehicleSlotIndex].bookedSpaces += 1
                    
                    // Update the selectedParkingSlot to reflect changes
                    selectedParkingSlot = parkingSlots[slotIndex]
                    
                    // Update the current booking's parking slot to reflect changes
                    currentBooking.parkingSlot = parkingSlots[slotIndex]
                    
                    // Show success message
                    alertMessage = "Booking confirmed! Your slot has been reserved."
                    showAlert = true
                    
                    // Debug output
                    print("Updated \(vehicleType.rawValue) spaces in \(parkingSlots[slotIndex].name): \(parkingSlots[slotIndex].vehicleSlots[vehicleSlotIndex].bookedSpaces)/\(parkingSlots[slotIndex].vehicleSlots[vehicleSlotIndex].totalSpaces)")
                } else {
                    // No available spaces
                    alertMessage = "Sorry, no available spaces for this vehicle type."
                    showAlert = true
                    return
                }
            } else {
                // Vehicle type not found
                alertMessage = "Invalid vehicle type selected."
                showAlert = true
                return
            }
        }
    }
    
    private func getVehicleType(from string: String) -> VehicleType {
        if string.lowercased().contains("car") {
            return .car
        } else if string.lowercased().contains("bike") || string.lowercased().contains("motor") {
            return .motorbike
        } else {
            return .bicycle
        }
    }
    
    func resetBookingForm() {
        // Keep the parking slot but reset all user input fields
        let parkingSlot = currentBooking.parkingSlot
        currentBooking = BookingInfo(parkingSlot: parkingSlot)
    }
    
    func dismissBookingSheet() {
        isShowingBookingSheet = false
        resetBookingForm()
    }
    
    func resetNavigation() {
        navigationPath = NavigationPath()
    }
}
