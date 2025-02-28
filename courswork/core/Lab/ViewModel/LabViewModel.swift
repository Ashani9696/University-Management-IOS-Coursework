//
//  LabViewModel.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-28.
//

import Foundation
import SwiftUI

class LabViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var labs: [Lab] = []
    @Published var subjects: [Subject] = Subject.sampleSubjects
    @Published var bookings: [BookingInfoLab] = []
    @Published var selectedLab: Lab?
    @Published var selectedSubject: Subject?
    @Published var currentBooking = BookingInfoLab(userId: "", labId: "", subjectId: "", date: Date(), duration: 3600)
    @Published var navigationPath = NavigationPath()
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    // Lab capacity management
    @Published var selectedQuantity = 1
    @Published var maxCapacity: [String: Int] = [:]
    @Published var bookedCapacity: [String: Int] = [:]
    
    // For sheet presentation
    @Published var isShowingBookingSheet = false
    @Published var bookingDate = Date()
    
    // User ID (would normally come from authentication)
    private let userId = "current_user_id"
    
    init() {
        // Initialize with sample data
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Create date components for lab hours
        var lab1StartComponents = DateComponents()
        lab1StartComponents.hour = 12
        lab1StartComponents.minute = 0
        
        var lab1EndComponents = DateComponents()
        lab1EndComponents.hour = 16
        lab1EndComponents.minute = 0
        
        var lab2StartComponents = DateComponents()
        lab2StartComponents.hour = 10
        lab2StartComponents.minute = 0
        
        var lab2EndComponents = DateComponents()
        lab2EndComponents.hour = 15
        lab2EndComponents.minute = 0
        
        var lab3StartComponents = DateComponents()
        lab3StartComponents.hour = 8
        lab3StartComponents.minute = 0
        
        var lab3EndComponents = DateComponents()
        lab3EndComponents.hour = 12
        lab3EndComponents.minute = 0
        
        // Create lab objects
        self.labs = [
            Lab(
                id: "lab1",
                name: "Lab 1",
                startTime: calendar.date(byAdding: lab1StartComponents, to: today)!,
                endTime: calendar.date(byAdding: lab1EndComponents, to: today)!
            ),
            Lab(
                id: "lab2",
                name: "Lab 2",
                startTime: calendar.date(byAdding: lab2StartComponents, to: today)!,
                endTime: calendar.date(byAdding: lab2EndComponents, to: today)!
            ),
            Lab(
                id: "lab3",
                name: "Lab 3",
                startTime: calendar.date(byAdding: lab3StartComponents, to: today)!,
                endTime: calendar.date(byAdding: lab3EndComponents, to: today)!
            )
        ]
        
        // Set capacities for each lab
        maxCapacity = [
            "lab1": 30,
            "lab2": 25,
            "lab3": 20
        ]
        
        // Initialize booked capacity
        bookedCapacity = [
            "lab1": 5,
            "lab2": 20,
            "lab3": 10
        ]
    }
    
    var filteredLabs: [Lab] {
        if searchText.isEmpty {
            return labs
        }
        return labs.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func selectLab(_ lab: Lab) {
        // Find the most up-to-date version of the lab
        if let index = labs.firstIndex(where: { $0.id == lab.id }) {
            selectedLab = labs[index]
            currentBooking = BookingInfoLab(
                userId: userId,
                labId: labs[index].id,
                subjectId: subjects.first?.id ?? "",
                date: labs[index].startTime,
                duration: labs[index].endTime.timeIntervalSince(labs[index].startTime)
            )
            selectedQuantity = 1
        }
        navigationPath.append("details")
    }
    
    func showBookingSheet() {
        print("Opening booking sheet")
        // Reset booking form except selected lab
        if let lab = selectedLab {
            currentBooking = BookingInfoLab(
                userId: userId,
                labId: lab.id,
                subjectId: subjects.first?.id ?? "",
                date: lab.startTime,
                duration: lab.endTime.timeIntervalSince(lab.startTime)
            )
            selectedQuantity = 1
            selectedSubject = subjects.first
            bookingDate = Date()
            isShowingBookingSheet = true
        }
    }
    
    func isLabAvailableForDate(_ date: Date, labId: String) -> Bool {
        // Always return true to allow multiple bookings for the same lab on the same day
        return true
    }
    
    func getRemainingCapacity(for labId: String) -> Int {
        let maxCap = maxCapacity[labId] ?? 0
        let bookedCap = bookedCapacity[labId] ?? 0
        return maxCap - bookedCap
    }
    
    func confirmBooking() {
        guard let lab = selectedLab, let subject = selectedSubject else {
            alertTitle = "Error"
            alertMessage = "Please select a lab and subject"
            showAlert = true
            return
        }
        
        // Check that all fields are filled
        if currentBooking.subjectId.isEmpty {
            alertTitle = "Missing Information"
            alertMessage = "Please select a subject"
            showAlert = true
            return
        }
        
        // Check if there's enough capacity
        let remainingCapacity = getRemainingCapacity(for: lab.id)
        if selectedQuantity > remainingCapacity {
            alertTitle = "Capacity Exceeded"
            alertMessage = "Selected quantity exceeds available capacity. Maximum available: \(remainingCapacity)"
            showAlert = true
            return
        }
        
        // Create a new booking
        let newBooking = BookingInfoLab(
            userId: userId,
            labId: lab.id,
            subjectId: subject.id,
            date: bookingDate,
            duration: lab.endTime.timeIntervalSince(lab.startTime),
            status: .confirmed
        )
        
        // Add the booking
        bookings.append(newBooking)
        
        // Update booked capacity
        bookedCapacity[lab.id] = (bookedCapacity[lab.id] ?? 0) + selectedQuantity
        
        // Update the lab's availability status if fully booked
        if let index = labs.firstIndex(where: { $0.id == lab.id }) {
            if getRemainingCapacity(for: lab.id) <= 0 {
                labs[index].isAvailable = false
            }
        }
        
        // Show success message
        alertTitle = "Success"
        alertMessage = "Booking confirmed! You've reserved \(selectedQuantity) slot(s) for \(subject.name) in \(lab.name)."
        showAlert = true
        isShowingBookingSheet = false
    }
    
    func getSubjectName(for id: String) -> String {
        return subjects.first(where: { $0.id == id })?.name ?? "Unknown Subject"
    }
    
    func dismissBookingSheet() {
        isShowingBookingSheet = false
    }
    
    func resetNavigation() {
        navigationPath = NavigationPath()
    }
}
