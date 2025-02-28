//
//  VehicleSlot.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-25.
//

import Foundation

struct VehicleSlot: Identifiable {
    let id = UUID()
    let vehicleType: VehicleType
    let totalSpaces: Int
    var bookedSpaces: Int
    
    var availableSpaces: Int {
        return totalSpaces - bookedSpaces
    }
    
    var isFullyBooked: Bool {
        return bookedSpaces >= totalSpaces
    }
    
    var availabilityText: String {
//        return "\(bookedSpaces)/\(totalSpaces)"
        return "\(totalSpaces - bookedSpaces)/\(totalSpaces)"
    }
}

//extension VehicleSlot {
//    var availabilityText: String {
//        return "\(totalSpaces - bookedSpaces)/\(totalSpaces)"
//    }
//}
