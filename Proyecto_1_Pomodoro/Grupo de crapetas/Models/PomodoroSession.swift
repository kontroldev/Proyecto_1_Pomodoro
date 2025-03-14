//
//  PomodoroSession.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 9/3/25.
//

import Foundation
import SwiftData

/// Modelo de datos para representar una sesión Pomodoro (normal, hábito o tarea)
@Model
class PomodoroSessionModel {
    
    /// Identificador único para cada sesión
    var id: UUID
    
    /// Fecha en la que se realizó la sesión
    var date: Date
    
    /// Duración de la sesión en segundos
    var duration: Int
    
    /// Tipo de sesión: puede ser "Pomodoro", "Hábito" o "Tarea"
    var type: String
    
    /// Inicializador de la sesión Pomodoro
    init(date: Date, duration: Int, type: String) {
        self.id = UUID()
        self.date = date
        self.duration = duration
        self.type = type
    }
}
