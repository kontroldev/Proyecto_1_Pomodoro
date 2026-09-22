//
//  TimerViewModelTests.swift
//  Proyecto_1_PomodoroTests
//

import Foundation
import SwiftData
import Testing
@testable import Proyecto_1_Pomodoro

/// Reloj manual: los tests deciden cuánto tiempo pasa.
@MainActor
final class TestClock {
    var now = Date(timeIntervalSinceReferenceDate: 0)

    func advance(by seconds: TimeInterval) {
        now = now.addingTimeInterval(seconds)
    }
}

@MainActor
struct TimerViewModelTests {
    let clock = TestClock()

    func makeViewModel(initialTime: Int = 60) -> TimerViewModel {
        TimerViewModel(initialTime: initialTime, now: { [clock] in clock.now })
    }

    func makeContext() throws -> ModelContext {
        let container = try ModelContainer(
            for: PomodoroSessionModel.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        return ModelContext(container)
    }

    @Test func startSetsEndDateFromClock() {
        let viewModel = makeViewModel(initialTime: 60)
        viewModel.start()

        #expect(viewModel.isRunning)
        #expect(viewModel.endDate == clock.now.addingTimeInterval(60))
        #expect(viewModel.timeRemaining == 60)
    }

    @Test func refreshComputesRemainingTimeFromEndDate() {
        let viewModel = makeViewModel(initialTime: 60)
        viewModel.start()

        clock.advance(by: 10)
        viewModel.refresh()
        #expect(viewModel.timeRemaining == 50)

        // Un salto grande (p. ej. la app en segundo plano) no pierde tiempo.
        clock.advance(by: 30)
        viewModel.refresh()
        #expect(viewModel.timeRemaining == 20)
    }

    @Test func partialSecondsRoundUp() {
        let viewModel = makeViewModel(initialTime: 60)
        viewModel.start()

        clock.advance(by: 0.4)
        viewModel.refresh()
        #expect(viewModel.timeRemaining == 60)
    }

    @Test func finishesAtZeroAndStops() {
        let viewModel = makeViewModel(initialTime: 60)
        viewModel.start()

        clock.advance(by: 90)
        viewModel.refresh()

        #expect(viewModel.timeRemaining == 0)
        #expect(viewModel.isFinished)
        #expect(!viewModel.isRunning)
        #expect(viewModel.endDate == nil)
    }

    @Test func pauseFreezesRemainingTime() {
        let viewModel = makeViewModel(initialTime: 60)
        viewModel.start()
        clock.advance(by: 15)
        viewModel.pause()

        #expect(!viewModel.isRunning)
        #expect(viewModel.timeRemaining == 45)

        // Mientras está en pausa, el reloj avanza pero el tiempo no.
        clock.advance(by: 100)
        viewModel.refresh()
        #expect(viewModel.timeRemaining == 45)

        viewModel.start()
        clock.advance(by: 5)
        viewModel.refresh()
        #expect(viewModel.timeRemaining == 40)
    }

    @Test func resetRestoresInitialState() {
        let viewModel = makeViewModel(initialTime: 60)
        viewModel.start()
        clock.advance(by: 20)
        viewModel.reset()

        #expect(!viewModel.isRunning)
        #expect(viewModel.timeRemaining == 60)
        #expect(viewModel.endDate == nil)
        #expect(viewModel.progress == 1)
    }

    @Test func finishAndSaveStoresElapsedTime() throws {
        let context = try makeContext()
        let viewModel = makeViewModel(initialTime: 60)
        viewModel.start()
        clock.advance(by: 25)

        viewModel.finishAndSave(type: .tarea, in: context)

        let sessions = try context.fetch(FetchDescriptor<PomodoroSessionModel>())
        #expect(sessions.count == 1)
        #expect(sessions.first?.duration == 25)
        #expect(sessions.first?.type == .tarea)
        #expect(viewModel.didSave)
        #expect(!viewModel.isRunning)
    }

    @Test func saveIsIdempotentAndSkipsEmptySessions() throws {
        let context = try makeContext()
        let viewModel = makeViewModel(initialTime: 60)

        viewModel.saveSession(type: .pomodoro, in: context)
        #expect(try context.fetchCount(FetchDescriptor<PomodoroSessionModel>()) == 0)

        viewModel.start()
        clock.advance(by: 60)
        viewModel.refresh()
        viewModel.saveSession(type: .pomodoro, in: context)
        viewModel.saveSession(type: .pomodoro, in: context)

        #expect(try context.fetchCount(FetchDescriptor<PomodoroSessionModel>()) == 1)
    }
}
