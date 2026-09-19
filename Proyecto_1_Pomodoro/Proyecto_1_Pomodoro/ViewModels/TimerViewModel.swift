//
//  TimerViewModel.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 9/3/25.
//

import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class TimerViewModel {
    private(set) var timeRemaining: Int
    private(set) var isRunning = false
    private(set) var didSave = false
    private(set) var saveErrorMessage: String?

    let initialTime: Int

    init(initialTime: Int = 1500) {
        self.initialTime = initialTime
        self.timeRemaining = initialTime
    }

    var elapsedTime: Int {
        initialTime - timeRemaining
    }

    var progress: Double {
        guard initialTime > 0 else { return 0 }
        return Double(timeRemaining) / Double(initialTime)
    }

    var isFinished: Bool {
        timeRemaining <= 0
    }

    func start() {
        guard !isRunning, !isFinished else { return }
        isRunning = true
    }

    func pause() {
        isRunning = false
    }

    func reset() {
        isRunning = false
        timeRemaining = initialTime
        didSave = false
        saveErrorMessage = nil
    }

    /// Cuenta atrás cooperativa: se cancela sola cuando la vista que la lanza
    /// desde `.task(id:)` desaparece o cuando `isRunning` cambia de valor.
    func runCountdown() async {
        while isRunning && timeRemaining > 0 {
            do {
                try await Task.sleep(for: .seconds(1))
            } catch {
                return
            }
            guard isRunning else { return }
            timeRemaining -= 1
        }

        if isFinished {
            isRunning = false
        }
    }

    func dismissSaveError() {
        saveErrorMessage = nil
    }

    func saveSession(type: SessionType, in modelContext: ModelContext) {
        guard !didSave, elapsedTime > 0 else { return }

        let session = PomodoroSessionModel(date: Date(), duration: elapsedTime, type: type)
        modelContext.insert(session)

        do {
            try modelContext.save()
            didSave = true
        } catch {
            saveErrorMessage = error.localizedDescription
        }
    }
}
