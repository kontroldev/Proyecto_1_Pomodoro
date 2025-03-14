//
//  Proyecto_1_PomodoroApp.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 8/3/25.
//

import SwiftUI
import SwiftData

@main
struct Proyecto_1_PomodoroApp: App {
    @State private var modelContainer = try! ModelContainer(for: PomodoroSessionModel.self)

    var body: some Scene {
        WindowGroup {
            ViewMockHome()
                .environment(\.modelContext, modelContainer.mainContext)
        }
    }
}
