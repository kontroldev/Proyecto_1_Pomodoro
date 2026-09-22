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

    /// Instante en el que termina la sesión en curso. Solo tiene valor mientras
    /// el temporizador está en marcha; al pausar se guarda `timeRemaining`.
    private(set) var endDate: Date?

    let initialTime: Int

    /// Reloj inyectable para poder controlar el tiempo en los tests.
    private let now: () -> Date

    init(initialTime: Int = 1500, now: @escaping () -> Date = Date.init) {
        self.initialTime = initialTime
        self.timeRemaining = initialTime
        self.now = now
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
        endDate = now().addingTimeInterval(TimeInterval(timeRemaining))
        isRunning = true
    }

    func pause() {
        refresh()
        isRunning = false
        endDate = nil
    }

    func reset() {
        isRunning = false
        endDate = nil
        timeRemaining = initialTime
        didSave = false
        saveErrorMessage = nil
    }

    /// Recalcula el tiempo restante a partir de `endDate` y la hora actual.
    /// Así el temporizador sigue siendo exacto aunque la app haya estado en
    /// segundo plano o el bucle de actualización se haya retrasado.
    func refresh() {
        guard isRunning, let endDate else { return }
        let remaining = endDate.timeIntervalSince(now())
        timeRemaining = max(0, Int(remaining.rounded(.up)))

        if isFinished {
            isRunning = false
            self.endDate = nil
        }
    }

    /// Bucle de refresco cooperativo: se cancela solo cuando la vista que lo
    /// lanza desde `.task(id:)` desaparece o cuando `isRunning` cambia de valor.
    /// No cuenta segundos: solo le pide a `refresh()` que recalcule.
    func runCountdown() async {
        while isRunning {
            refresh()
            guard isRunning else { return }
            do {
                try await Task.sleep(for: .milliseconds(250))
            } catch {
                return
            }
        }
    }

    func dismissSaveError() {
        saveErrorMessage = nil
    }

    func saveSession(type: SessionType, in modelContext: ModelContext) {
        guard !didSave, elapsedTime > 0 else { return }

        let session = PomodoroSessionModel(date: now(), duration: elapsedTime, type: type)
        modelContext.insert(session)

        do {
            try modelContext.save()
            didSave = true
        } catch {
            saveErrorMessage = error.localizedDescription
        }
    }

    /// Detiene el temporizador y guarda el tiempo transcurrido hasta ahora.
    func finishAndSave(type: SessionType, in modelContext: ModelContext) {
        pause()
        saveSession(type: type, in: modelContext)
    }
}
