//
//  HomeViewModel.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedFeature: String? = nil
    
    let features = [
        Feature(
            icon: "mappin.circle.fill",
            title: "Find\nLocation",
            backgroundColor: .white,
            foregroundColor: .black,
            borderColor: Color(.systemGray5),
            destination: "LocationView"
        ),
        Feature(
            icon: "p.square.fill",
            title: "Find\nParking",
            backgroundColor: .white,
            foregroundColor: .black,
            borderColor: Color(.systemGray5),
            destination: "ParkingView"
        ),
        Feature(
            icon: "bell.fill",
            title: "University\nCafeterias",
            backgroundColor: .white,
            foregroundColor: .black,
            borderColor: Color(.systemGray5),
            destination: "CafeteriasView"
        ),
        Feature(
            icon: "flask.fill",
            title: "University\nLabs",
            backgroundColor: .white,
            foregroundColor: .black,
            borderColor: Color(.systemGray5),
            destination: "LabView"
        )
    ]
}
