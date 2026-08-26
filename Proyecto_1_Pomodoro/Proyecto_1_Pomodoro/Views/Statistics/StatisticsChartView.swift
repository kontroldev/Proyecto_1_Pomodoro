//
//  StatisticsChartView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 8/3/25.
//

import SwiftUI
import Charts

struct StatisticsChartView: View {
    @State private var pomodoroData: [StatisticsSession] = [
        StatisticsSession(day: "Lunes", type: "Pomodoro", count: 5),
        StatisticsSession(day: "Lunes", type: "Habito", count: 1),
        StatisticsSession(day: "Lunes", type: "Tarea", count: 2),
        StatisticsSession(day: "Martes", type: "Pomodoro", count: 3),
        StatisticsSession(day: "Martes", type: "Habito", count: 2),
        StatisticsSession(day: "Martes", type: "Tarea", count: 1),
        StatisticsSession(day: "Miercoles", type: "Pomodoro", count: 4),
        StatisticsSession(day: "Miercoles", type: "Habito", count: 1),
        StatisticsSession(day: "Miercoles", type: "Tarea", count: 3)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Grafico de avances")
                .font(.headline)
                .bold()
                .padding(.horizontal)

            Chart {
                ForEach(pomodoroData) { session in
                    BarMark(
                        x: .value("Dia", session.day),
                        y: .value("Cantidad", session.count)
                    )
                    .foregroundStyle(color(for: session.type))
                    .annotation(position: .overlay) {
                        Text("\(session.count)")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(height: 200)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding(.vertical)
    }

    private func color(for type: String) -> Color {
        switch type {
        case "Pomodoro":
            return .red
        case "Habito":
            return .green
        default:
            return .blue
        }
    }
}

#Preview {
    StatisticsChartView()
}
