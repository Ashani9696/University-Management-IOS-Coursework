//
//  Feature.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

struct Feature: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    let destination: String
}
