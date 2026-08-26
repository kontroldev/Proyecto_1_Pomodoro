//
//  TimerViewModel.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 9/3/25.
//

import Foundation
import SwiftData

final class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int
    @Published var isRunning = false

    let initialTime: Int

    private var timer: Timer?
    private var modelContext: ModelContext?

    init(initialTime: Int = 1500) {
        self.initialTime = initialTime
        self.timeRemaining = initialTime
    }

    func setModelContextIfNeeded(_ context: ModelContext) {
        guard modelContext == nil else { return }
        modelContext = context
    }

    func startTimer() {
        guard !isRunning else { return }
        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }

    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    func resetTimer() {
        pauseTimer()
        timeRemaining = initialTime
    }

    func saveSession(type: String) {
        guard let modelContext else { return }

        let session = PomodoroSessionModel(date: Date(), duration: initialTime, type: type)
        modelContext.insert(session)

        do {
            try modelContext.save()
        } catch {
            print("Error al guardar la sesion Pomodoro: \(error.localizedDescription)")
        }
    }

    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
}
