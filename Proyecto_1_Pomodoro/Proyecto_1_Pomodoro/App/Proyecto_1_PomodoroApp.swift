// xcode: set sdk=iOS

//
//  Proyecto_1_PomodoroApp.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 8/3/25.
//

import SwiftUI
import SwiftData

@main
struct Proyecto_1_PomodoroApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: PomodoroSessionModel.self)
    }
}
