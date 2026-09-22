//
//  TimerRoute.swift
//  Proyecto_1_Pomodoro
//

import Foundation

/// Destino de navegación hacia `TimerView`. Al navegar por valor, la vista
/// del temporizador solo se construye cuando el usuario pulsa el botón.
struct TimerRoute: Hashable {
    let seconds: Int
    let type: SessionType
}
