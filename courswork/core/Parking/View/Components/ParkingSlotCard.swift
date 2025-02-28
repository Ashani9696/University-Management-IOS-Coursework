//
//  ParkingSlotCard.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation
import SwiftUI

struct ParkingSlotCard: View {
    let slot: ParkingSlot
    var onCheckNowTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(slot.name)
                .font(.system(size: 16, weight: .medium))
            
            Text(slot.location)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            HStack {
                Spacer() // Push buttons to the right
                
                Button(action: {
                    onCheckNowTapped()
                }) {
                    Text("Check Now")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(slot.isFullyBooked ? Color.gray : Color.blue)
                        .cornerRadius(16)
                }
                .disabled(slot.isFullyBooked)
                
                if slot.isCrowded {
                    Text("Crowded")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.red)
                        .cornerRadius(16)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
