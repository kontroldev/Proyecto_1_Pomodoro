//
//  SessionType+Tint.swift
//  Proyecto_1_Pomodoro
//

import SwiftUI

extension SessionType {
    var tint: Color {
        switch self {
        case .pomodoro: return .red
        case .habito: return .purple
        case .tarea: return .green
        }
    }
}
