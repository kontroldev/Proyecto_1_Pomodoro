//
//  HomeView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 8/3/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTime = 25 * 60

    private let defaultTimes = [25, 30, 40]

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Bienvenido a Pomodoro")
                    .font(.title)
                    .padding(.top)

                HStack(spacing: 12) {
                    ForEach(defaultTimes, id: \.self) { minutes in
                        Button {
                            selectedTime = minutes * 60
                        } label: {
                            Text("\(minutes) min")
                                .frame(width: 92)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(selectedTime == minutes * 60 ? .blue : .gray)
                    }
                }

                Picker("Tiempo personalizado", selection: $selectedTime) {
                    ForEach(1...120, id: \.self) { minute in
                        Text("\(minute) min").tag(minute * 60)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 120)

                NavigationLink {
                    TimerView(selectedTime: selectedTime, sessionType: "Pomodoro")
                } label: {
                    Text("Empezar Pomodoro")
                        .frame(width: 180)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)

                HStack(spacing: 15) {
                    NavigationLink {
                        TimerView(selectedTime: 60 * 60, sessionType: "Habito")
                    } label: {
                        Text("Habitos")
                            .frame(width: 120)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)

                    NavigationLink {
                        TimerView(selectedTime: 25 * 60, sessionType: "Tarea")
                    } label: {
                        Text("Tareas")
                            .frame(width: 120)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
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
}
