//
//  ItemMenu.swift
//  Proyecto_1_Pomodoro
//
//  Created by Juito on 20/1/25.
//

import Foundation
import SwiftUI

// Modelo para crear los botones de la pantalla principal
struct ItemMenu: Identifiable {
    var id = UUID()
    var mainButtonText: String
    var mainButtonIco: String
    var mainButtonColor: String
    var mainButtonlink: AnyView
}

//Datos para la creación de los botones
//Aquí se pueden cambiar los destinos de los botones

@MainActor let menuItem: [ItemMenu] = [
    .init(mainButtonText: "Empezar Pomodoro", mainButtonIco: "fitness.timer", mainButtonColor: "StartSessionButtonColor", mainButtonlink: AnyView(NombreSesionView())),
    .init(mainButtonText: "Ver hábitos", mainButtonIco: "figure.gymnastics.circle", mainButtonColor: "HabitosButtonColor", mainButtonlink: AnyView(Text("Vista Hábitos"))),
    .init(mainButtonText: "Ver tareas", mainButtonIco: "checklist", mainButtonColor: "TareasButtonColor", mainButtonlink: AnyView(Text("Vista Tareas")))
    ]
