//
//  journalApp1App.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 19/10/2025.
//
import SwiftUI

@main
struct JournaliApp: App {
    @StateObject private var journal = JournalViewModel()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(journal)
        }
    }
}
