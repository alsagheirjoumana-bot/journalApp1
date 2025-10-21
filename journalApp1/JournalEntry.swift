//
//  ContentView.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 19/10/2025.
//

import Foundation

struct JournalEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var date: Date
    var title: String
    var body: String
    var isBookmarked: Bool

    init(
        id: UUID = UUID(),
        date: Date = .now,
        title: String,
        body: String,
        isBookmarked: Bool = false
    ) {
        self.id = id
        self.date = date
        self.title = title
        self.body = body
        self.isBookmarked = isBookmarked
    }
}


