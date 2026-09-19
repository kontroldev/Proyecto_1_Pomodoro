//
//  HomeView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 8/3/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedMinutes = 25

    private let defaultMinutes = [25, 30, 40]

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Bienvenido a Pomodoro")
                    .font(.title)
                    .padding(.top)

                HStack(spacing: 12) {
                    ForEach(defaultMinutes, id: \.self) { minutes in
                        Button {
                            selectedMinutes = minutes
                        } label: {
                            Text("\(minutes) min")
                                .frame(width: 92)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(selectedMinutes == minutes ? .blue : .gray)
                    }
                }

                Picker("Tiempo personalizado", selection: $selectedMinutes) {
                    ForEach(1...120, id: \.self) { minute in
                        Text("\(minute) min").tag(minute)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 120)

                NavigationLink {
                    TimerView(selectedTime: selectedMinutes * 60, sessionType: .pomodoro)
                } label: {
                    Text("Empezar Pomodoro")
                        .frame(width: 180)
                }
                .buttonStyle(.borderedProminent)
                .tint(SessionType.pomodoro.tint)

                HStack(spacing: 15) {
                    NavigationLink {
                        TimerView(selectedTime: 60 * 60, sessionType: .habito)
                    } label: {
                        Text("Habitos")
                            .frame(width: 120)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(SessionType.habito.tint)

                    NavigationLink {
                        TimerView(selectedTime: 25 * 60, sessionType: .tarea)
                    } label: {
                        Text("Tareas")
                            .frame(width: 120)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(SessionType.tarea.tint)
                }

                StatisticsChartView()

                Spacer()
            }
            .padding()
            .navigationTitle("Inicio")
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: PomodoroSessionModel.self, inMemory: true)
}
