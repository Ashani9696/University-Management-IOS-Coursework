//
//  ParkingSlot.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation

struct ParkingSlot: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    var vehicleSlots: [VehicleSlot]
    var isCrowded: Bool
    let imageName: String
    
    var isFullyBooked: Bool {
        // Return true if all vehicle types are fully booked
        return vehicleSlots.allSatisfy { $0.isFullyBooked }
    }
}
