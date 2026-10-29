//
//  HabitStore.swift
//  HabitTracker
//
//  Created by iOS Maintainer on 29/10/26.
//

import Combine
import Foundation

@MainActor
final class HabitStore: ObservableObject {

    // MARK: - Private Properties

    private let calendar = Calendar.current

    // MARK: - Properties

    @Published private(set) var habits: [Habit]

    // MARK: - Initializers

    init(habits: [Habit] = []) {
        self.habits = habits
    }

    // MARK: - Functions

    func addHabit(named name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        habits.append(Habit(name: trimmed))
    }

    func toggleCompletion(for habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }

        let today = calendar.startOfDay(for: .now)
        habits[index].isCompleted.toggle()

        if habits[index].isCompleted {
            habits[index].completedDays.insert(today)
        } else {
            habits[index].completedDays.remove(today)
        }

        habits[index].streak = calculateStreak(for: habits[index])
    }

    func calculateStreak(for habit: Habit) -> Int {
        var streak = 0
        var day = calendar.startOfDay(for: .now)

        while habit.completedDays.contains(day) {
            streak += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: day) else { break }
            day = previous
        }

        return streak
    }

    func formatStreak(_ streak: Int) -> String {
        "\(streak) days"
    }
}
