//
//  ContentView.swift
//  HabitTracker
//
//  Created by iOS Maintainer on 29/10/26.
//

import SwiftUI

struct ContentView: View {

    // MARK: - States

    @State private var newHabitName = ""

    // MARK: - Environment

    @EnvironmentObject private var store: HabitStore

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        TextField("New habit", text: $newHabitName)
                            .onSubmit(addHabit)
                        Button("Add", action: addHabit)
                            .disabled(newHabitName.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                }

                Section("Habits") {
                    ForEach(store.habits) { habit in
                        habitRow(habit)
                    }
                }
            }
            .navigationTitle("Habit Tracker")
        }
    }

    // MARK: - Private Views

    @ViewBuilder
    private func habitRow(_ habit: Habit) -> some View {
        Button {
            store.toggleCompletion(for: habit)
        } label: {
            HStack {
                Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(habit.isCompleted ? .green : .secondary)
                Text(habit.name)
                    .foregroundStyle(.primary)
                Spacer()
                Text(store.formatStreak(habit.streak))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - Private Functions

    private func addHabit() {
        store.addHabit(named: newHabitName)
        newHabitName = ""
    }
}

// MARK: - Preview

#Preview {
    ContentView()
        .environmentObject(HabitStore(habits: [Habit(name: "Read"), Habit(name: "Exercise")]))
}
