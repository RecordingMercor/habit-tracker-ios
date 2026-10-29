//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by iOS Maintainer on 29/10/26.
//

import SwiftUI

@main
struct HabitTrackerApp: App {

    // MARK: - States

    @StateObject private var store = HabitStore()

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
