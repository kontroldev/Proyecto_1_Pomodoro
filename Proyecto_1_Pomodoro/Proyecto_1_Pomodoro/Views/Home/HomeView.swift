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
            ScrollView {
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
                                    .frame(maxWidth: .infinity)
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

                    NavigationLink(value: TimerRoute(seconds: selectedMinutes * 60, type: .pomodoro)) {
                        Text("Empezar Pomodoro")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(SessionType.pomodoro.tint)

                    HStack(spacing: 12) {
                        NavigationLink(value: TimerRoute(seconds: 60 * 60, type: .habito)) {
                            Text("Hábitos")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(SessionType.habito.tint)

                        NavigationLink(value: TimerRoute(seconds: 25 * 60, type: .tarea)) {
                            Text("Tareas")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(SessionType.tarea.tint)
                    }

                    StatisticsChartView()
                }
                .padding()
            }
            .navigationTitle("Inicio")
            .navigationDestination(for: TimerRoute.self) { route in
                TimerView(selectedTime: route.seconds, sessionType: route.type)
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: PomodoroSessionModel.self, inMemory: true)
}
