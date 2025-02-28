//
//  Constants.swift
//  courswork
//
//  Created by Ashani Dilanka on 2025-02-24.
//

import Foundation

struct Constants {
    static let tabBarItems = [
        TabItem(icon: "house.fill", title: "Home"),
        TabItem(icon: "p.square", title: "Parking"),
        TabItem(icon: "magnifyingglass", title: "Search"),
        TabItem(icon: "person", title: "User")
    ]
}

struct TabItem {
    let icon: String
    let title: String
}
