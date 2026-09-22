//
//  StatisticsSession.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 8/3/25.
//

import Foundation

struct StatisticsSession: Identifiable, Equatable {
    let day: Date
    let type: SessionType
    let minutes: Int

    var id: String { "\(day.timeIntervalSinceReferenceDate)-\(type.rawValue)" }
}

extension StatisticsSession {
    /// Agrupa las sesiones por día y tipo y suma su duración en minutos.
    /// Los segundos se suman antes de convertir, para que varias sesiones
    /// cortas no se pierdan por redondeo. Resultado ordenado por día y tipo.
    static func daily(
        from sessions: [PomodoroSessionModel],
        calendar: Calendar = .current
    ) -> [StatisticsSession] {
        struct Key: Hashable {
            let day: Date
            let type: SessionType
        }

        var secondsByKey: [Key: Int] = [:]
        for session in sessions {
            let key = Key(day: calendar.startOfDay(for: session.date), type: session.type)
            secondsByKey[key, default: 0] += session.duration
        }

        let typeOrder = Dictionary(uniqueKeysWithValues: SessionType.allCases.enumerated().map { ($1, $0) })

        return secondsByKey
            .map { key, seconds in
                StatisticsSession(
                    day: key.day,
                    type: key.type,
                    minutes: Int((Double(seconds) / 60).rounded())
                )
            }
            .sorted {
                ($0.day, typeOrder[$0.type, default: 0]) < ($1.day, typeOrder[$1.type, default: 0])
            }
    }
}
