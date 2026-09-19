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
    let count: Int

    var id: String { "\(day.timeIntervalSinceReferenceDate)-\(type.rawValue)" }
}
