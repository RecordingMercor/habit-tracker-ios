//
//  HabitTrackerTests.swift
//  HabitTrackerTests
//
//  Created by iOS Maintainer on 29/10/26.
//

import Testing
@testable import HabitTracker

@MainActor
struct HabitTrackerTests {

    // MARK: - Functions

    @Test func toggleCompletionMarksHabitAndUpdatesStreak() throws {
        let store = HabitStore(habits: [Habit(name: "Read")])
        let habit = try #require(store.habits.first)

        store.toggleCompletion(for: habit)

        #expect(store.habits[0].isCompleted)
        #expect(store.habits[0].streak == 1)

        store.toggleCompletion(for: store.habits[0])

        #expect(!store.habits[0].isCompleted)
        #expect(store.habits[0].streak == 0)
    }

    @Test func formatStreakReturnsDaysString() {
        let store = HabitStore()

        #expect(store.formatStreak(3) == "🔥 3 days")
    }
}
