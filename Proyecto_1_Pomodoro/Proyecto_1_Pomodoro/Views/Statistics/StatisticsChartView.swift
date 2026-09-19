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
            Text("Grafico de avances")
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
                    y: .value("Cantidad", entry.count)
                )
                .foregroundStyle(by: .value("Tipo", entry.type.displayName))
                .annotation(position: .overlay) {
                    Text("\(entry.count)")
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
        let calendar = Calendar.current
        let byDay = Dictionary(grouping: sessions) { calendar.startOfDay(for: $0.date) }

        return byDay
            .flatMap { day, sessionsForDay in
                Dictionary(grouping: sessionsForDay, by: \.type)
                    .map { type, sessionsForType in
                        StatisticsSession(day: day, type: type, count: sessionsForType.count)
                    }
            }
            .sorted { $0.day < $1.day }
    }
}

#Preview {
    StatisticsChartView()
        .modelContainer(for: PomodoroSessionModel.self, inMemory: true)
}
