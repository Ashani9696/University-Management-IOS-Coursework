//
//  LabBookingFormView.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-28.
//

import Foundation
import SwiftUI

struct LabBookingFormView: View {
    @ObservedObject var viewModel: LabViewModel
    
    // Computed property to get tomorrow's date
    private var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                if let lab = viewModel.selectedLab {
                    Section(header: Text("Lab Information")) {
                        Text(lab.name)
                        Text(lab.timeRangeFormatted)
                    }
                }
                
                Section(header: Text("Subject")) {
                    Picker("Select Subject", selection: $viewModel.selectedSubject) {
                        ForEach(viewModel.subjects) { subject in
                            Text(subject.name).tag(Optional(subject))
                        }
                    }
                    .onChange(of: viewModel.selectedSubject) { _, newValue in
                        if let subject = newValue {
                            viewModel.currentBooking.subjectId = subject.id
                        }
                    }
                }
                
                Section(header: Text("Date")) {
                    DatePicker(
                        "Select Date",
                        selection: $viewModel.bookingDate,
                        in: tomorrow...,
                        displayedComponents: .date
                    )
                }
                
                Section(header: Text("Quantity")) {
                    if let labId = viewModel.selectedLab?.id {
                        let remainingCapacity = viewModel.getRemainingCapacity(for: labId)
                        
                        Stepper(value: $viewModel.selectedQuantity, in: 1...max(1, remainingCapacity)) {
                            Text("Number of slots: \(viewModel.selectedQuantity)")
                        }
                        
                        Text("Maximum available: \(remainingCapacity)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Book Lab")
            .navigationBarItems(
                leading: Button("Cancel") {
                    viewModel.dismissBookingSheet()
                },
                trailing: Button("Confirm") {
                    viewModel.confirmBooking()
                }
            )
        }
    }
}
