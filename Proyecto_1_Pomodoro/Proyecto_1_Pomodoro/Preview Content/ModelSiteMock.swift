//
//  ModelSiteMock.swift
//  Proyecto_1_Pomodoro
//
//  Created by Esteban Pérez Castillejo on 26/1/25.
//

import Foundation

// Modelo para representar avisos hechos por días
struct ModelShartsSmok: Identifiable {
    var id = UUID()
    var dia: String // Día de la semana o fecha
    var avisos: Int // Cantidad de avisos realizados
}

// Ejemplo de datos ficticios
@MainActor let sample_Avisos: [ModelShartsSmok] = [
    ModelShartsSmok(dia: "Lunes", avisos: 5),
    ModelShartsSmok(dia: "Martes", avisos: 8),
    ModelShartsSmok(dia: "Miércoles", avisos: 3),
    ModelShartsSmok(dia: "Jueves", avisos: 10),
    ModelShartsSmok(dia: "Viernes", avisos: 7),
    ModelShartsSmok(dia: "Sábado", avisos: 6),
    ModelShartsSmok(dia: "Domingo", avisos: 4)
]


