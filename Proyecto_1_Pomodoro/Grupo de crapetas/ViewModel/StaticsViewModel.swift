//
//  StaticsViewModel.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 9/3/25.
//

import Foundation
import SwiftData

class StatisticsViewModel: ObservableObject {
    @Published var sessions: [PomodoroSessionModel] = []
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadSessions()
    }

    func loadSessions() {
        let descriptor = FetchDescriptor<PomodoroSessionModel>()
        sessions = (try? modelContext.fetch(descriptor)) ?? []
    }

    var totalTime: Int {
        sessions.reduce(0) { $0 + $1.duration }
    }

    var totalSessions: Int {
        sessions.count
    }

    var habitsTime: Int {
        sessions.filter { $0.type == "Hábito" }.reduce(0) { $0 + $1.duration }
    }

    var tasksTime: Int {
        sessions.filter { $0.type == "Tarea" }.reduce(0) { $0 + $1.duration }
    }
}
