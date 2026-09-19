//
//  SessionType.swift
//  Proyecto_1_Pomodoro
//

import Foundation

enum SessionType: String, Codable, CaseIterable, Identifiable {
    case pomodoro = "Pomodoro"
    case habito = "Habito"
    case tarea = "Tarea"

    var id: Self { self }

    var displayName: String {
        switch self {
        case .pomodoro: return "Pomodoro"
        case .habito: return "Hábito"
        case .tarea: return "Tarea"
        }
    }
}
