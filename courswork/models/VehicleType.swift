//
//  VehicleType.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-25.
//

import Foundation

enum VehicleType: String, CaseIterable, Identifiable {
    case car = "Car"
    case motorbike = "Motorbike"
    case bicycle = "Bicycle"
    
    var id: String { self.rawValue }
}
