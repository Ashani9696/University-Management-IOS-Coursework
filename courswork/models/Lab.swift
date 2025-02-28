//
//  Lab.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-28.
//

import Foundation

struct Lab: Identifiable, Codable {
    var id: String
    var name: String
    var startTime: Date
    var endTime: Date
    var isAvailable: Bool
    var subjectId: String?
    
    init(id: String, name: String, startTime: Date, endTime: Date, isAvailable: Bool = true, subjectId: String? = nil) {
        self.id = id
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.isAvailable = isAvailable
        self.subjectId = subjectId
    }
    
    var timeRangeFormatted: String {
        let startFormatter = DateFormatter()
        startFormatter.dateFormat = "h:mm a"
        let endFormatter = DateFormatter()
        endFormatter.dateFormat = "h:mm a"
        
        return "\(startFormatter.string(from: startTime)) - \(endFormatter.string(from: endTime))"
    }
}
