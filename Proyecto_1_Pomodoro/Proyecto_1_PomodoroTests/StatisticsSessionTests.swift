//
//  StatisticsSessionTests.swift
//  Proyecto_1_PomodoroTests
//

import Foundation
import Testing
@testable import Proyecto_1_Pomodoro

struct StatisticsSessionTests {
    let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Europe/Madrid")!
        return calendar
    }()

    func date(_ day: Int, _ hour: Int, _ minute: Int = 0) -> Date {
        calendar.date(from: DateComponents(year: 2026, month: 9, day: day, hour: hour, minute: minute))!
    }

    @Test func emptyInputGivesEmptyOutput() {
        #expect(StatisticsSession.daily(from: [], calendar: calendar).isEmpty)
    }

    @Test func sumsMinutesPerDayAndType() {
        let sessions = [
            PomodoroSessionModel(date: date(21, 9), duration: 25 * 60, type: .pomodoro),
            PomodoroSessionModel(date: date(21, 18), duration: 25 * 60, type: .pomodoro),
            PomodoroSessionModel(date: date(21, 12), duration: 10 * 60, type: .tarea),
            PomodoroSessionModel(date: date(22, 8), duration: 60 * 60, type: .habito),
        ]

        let stats = StatisticsSession.daily(from: sessions, calendar: calendar)

        #expect(stats == [
            StatisticsSession(day: calendar.startOfDay(for: date(21, 0)), type: .pomodoro, minutes: 50),
            StatisticsSession(day: calendar.startOfDay(for: date(21, 0)), type: .tarea, minutes: 10),
            StatisticsSession(day: calendar.startOfDay(for: date(22, 0)), type: .habito, minutes: 60),
        ])
    }

    @Test func sumsSecondsBeforeConvertingToMinutes() {
        // Tres sesiones de 40 s = 120 s = 2 min (redondear cada una daría 3).
        let sessions = (0..<3).map {
            PomodoroSessionModel(date: date(21, 10, $0), duration: 40, type: .pomodoro)
        }

        let stats = StatisticsSession.daily(from: sessions, calendar: calendar)

        #expect(stats.map(\.minutes) == [2])
    }

    @Test func sessionsAroundMidnightGoToTheirOwnDay() {
        let sessions = [
            PomodoroSessionModel(date: date(21, 23, 59), duration: 60, type: .pomodoro),
            PomodoroSessionModel(date: date(22, 0, 1), duration: 60, type: .pomodoro),
        ]

        let stats = StatisticsSession.daily(from: sessions, calendar: calendar)

        #expect(stats.count == 2)
        #expect(stats.map(\.day) == [
            calendar.startOfDay(for: date(21, 0)),
            calendar.startOfDay(for: date(22, 0)),
        ])
    }
}
