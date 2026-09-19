//
//  PomodoroSessionModel.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 9/3/25.
//

import Foundation
import SwiftData

@Model
final class PomodoroSessionModel {
    var date: Date
    var duration: Int
    var type: SessionType

    init(date: Date, duration: Int, type: SessionType) {
        self.date = date
        self.duration = duration
        self.type = type
    }
}
