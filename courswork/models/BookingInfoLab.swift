//
//  BookingInfoLab.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-28.
//

import Foundation

struct BookingInfoLab: Identifiable, Codable {
    var id: String
    var userId: String
    var labId: String
    var subjectId: String
    var date: Date
    var duration: TimeInterval
    var status: BookingStatus
    
    init(id: String = UUID().uuidString,
         userId: String,
         labId: String,
         subjectId: String,
         date: Date,
         duration: TimeInterval,
         status: BookingStatus = .pending) {
        self.id = id
        self.userId = userId
        self.labId = labId
        self.subjectId = subjectId
        self.date = date
        self.duration = duration
        self.status = status
    }
    
    enum BookingStatus: String, Codable {
        case pending
        case confirmed
        case cancelled
        case completed
    }
}
