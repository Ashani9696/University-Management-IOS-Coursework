//
//  Subject.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-28.
//

import Foundation

struct Subject: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    static let sampleSubjects = [
        Subject(id: "cs101", name: "Computer Science 101"),
        Subject(id: "bio202", name: "Biology 202"),
        Subject(id: "chem303", name: "Chemistry 303"),
        Subject(id: "phys404", name: "Physics 404")
    ]
}
