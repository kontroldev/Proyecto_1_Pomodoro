//
//  StatisticsChartView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 8/3/25.
//

import SwiftUI
import SwiftData
import Charts

struct StatisticsChartView: View {
    @Query(sort: \PomodoroSessionModel.date) private var sessions: [PomodoroSessionModel]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Gráfico de avances")
                .font(.headline)
                .bold()
                .padding(.horizontal)

            content
                .frame(height: 200)
                .padding()
                .background(.background, in: .rect(cornerRadius: 10))
                .shadow(radius: 5)
        }
        .padding(.vertical)
    }

    @ViewBuilder
    private var content: some View {
        if statistics.isEmpty {
            ContentUnavailableView(
                "Sin sesiones todavía",
                systemImage: "chart.bar",
                description: Text("Completa tu primera sesión para ver aquí tu progreso.")
            )
        } else {
            Chart(statistics) { entry in
                BarMark(
                    x: .value("Día", entry.day, unit: .day),
                    y: .value("Minutos", entry.minutes)
                )
                .foregroundStyle(by: .value("Tipo", entry.type.displayName))
                .annotation(position: .overlay) {
                    Text("\(entry.minutes)")
                        .font(.caption)
                        .foregroundStyle(.white)
                }
            }
            .chartForegroundStyleScale([
                SessionType.pomodoro.displayName: SessionType.pomodoro.tint,
                SessionType.habito.displayName: SessionType.habito.tint,
                SessionType.tarea.displayName: SessionType.tarea.tint
            ])
        }
    }

    private var statistics: [StatisticsSession] {
        StatisticsSession.daily(from: sessions)
    }
}

#Preview {
    StatisticsChartView()
        .modelContainer(for: PomodoroSessionModel.self, inMemory: true)
}
