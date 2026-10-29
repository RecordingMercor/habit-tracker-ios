//
//  Habit.swift
//  HabitTracker
//
//  Created by iOS Maintainer on 29/10/26.
//

import Foundation

struct Habit: Identifiable, Equatable {

    // MARK: - Properties

    let id: UUID
    var name: String
    var isCompleted: Bool
    var streak: Int
    var completedDays: Set<Date>

    // MARK: - Initializers

    init(
        id: UUID = UUID(),
        name: String,
        isCompleted: Bool = false,
        streak: Int = 0,
        completedDays: Set<Date> = []
    ) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.streak = streak
        self.completedDays = completedDays
    }
}
