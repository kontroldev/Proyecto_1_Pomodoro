//
//  StatisticsSession.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 8/3/25.
//

import Foundation

struct StatisticsSession: Identifiable {
    let id = UUID()
    let day: String
    let type: String
    let count: Int
}
