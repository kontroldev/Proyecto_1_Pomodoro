//
//  ViewMockHome.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 8/3/25.
//

import SwiftUI
import Charts


struct ViewMockHome: View {
    @State private var selectedTime: Int? = nil
    @State private var customTime: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Bienvenido a Pomodoro")
                    .font(.title)
                    .padding()

                // Botones para seleccionar el tiempo
                HStack {
                    ForEach([25, 30, 40], id: \.self) { time in
                        Button(action: {
                            selectedTime = time * 60
                            customTime = ""
                        }) {
                            Text("\(time) min")
                                .padding()
                                .frame(width: 100)
                                .background(selectedTime == time * 60 ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.bottom, 0) // Reducción de la separación

                // Campo de selección para tiempo personalizado (en vez de TextField)
                Picker("Tiempo personalizado", selection: $selectedTime) {
                    ForEach(1...120, id: \.self) { minute in
                        Text("\(minute) min").tag(minute * 60)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 100)

                // Botón para iniciar Pomodoro
                NavigationLink(
                    destination: PomodoroTimerView(selectedTime: selectedTime ?? ((Int(customTime) ?? 0) * 60))
                ) {
                    Text("Empezar Pomodoro")
                        .padding()
                        .frame(width: 180)
                        .background((selectedTime != nil || (Int(customTime) ?? 0) > 0) ? Color.red : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(selectedTime == nil && (Int(customTime) ?? 0) == 0)

                // Botones para ver hábitos y tareas
                HStack(spacing: 15) {
                    NavigationLink(destination: PomodoroTimerView(selectedTime: 3600)) {
                        Text("Hábitos")
                            .padding()
                            .frame(width: 140)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: PomodoroTimerView(selectedTime: 1500)) {
                        Text("Tareas")
                            .padding()
                            .frame(width: 140)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                // Espacio para la gráfica
                VStack {
                    Text("Estadísticas")
                        .font(.headline)
                        .padding(.top, 5)

                    ChartsComponentView()
                }
                .padding()
            }
            .navigationTitle("Inicio")
        }
        
    }
}

// Nueva vista para elegir entre hábito o tarea
struct SessionTypeSelectionView: View {
    @Binding var selectedTime: Int?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Selecciona el tipo de sesión")
                .font(.title2)
                .padding()

            Button(action: {
                selectedTime = 3600 // 60 minutos
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Hábito")
                    .padding()
                    .frame(width: 150)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                selectedTime = 1500 // 25 minutos
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Tarea")
                    .padding()
                    .frame(width: 150)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct PomodoroSession: Identifiable {
    var id = UUID()
    var day: String
    var type: String // "Normal", "Hábito", "Tarea"
    var count: Int
}

struct ChartsComponentView: View {
    @State private var pomodoroData: [PomodoroSession] = [
        PomodoroSession(day: "Lunes", type: "Normal", count: 5),
        PomodoroSession(day: "Lunes", type: "Hábito", count: 1),
        PomodoroSession(day: "Lunes", type: "Tarea", count: 2),
        PomodoroSession(day: "Martes", type: "Normal", count: 3),
        PomodoroSession(day: "Martes", type: "Hábito", count: 2),
        PomodoroSession(day: "Martes", type: "Tarea", count: 1),
        PomodoroSession(day: "Miércoles", type: "Normal", count: 4),
        PomodoroSession(day: "Miércoles", type: "Hábito", count: 1),
        PomodoroSession(day: "Miércoles", type: "Tarea", count: 3)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Gráfico de Avances")
                .font(.headline)
                .bold()
                .padding()

            Chart {
                ForEach(pomodoroData) { session in
                    BarMark(
                        x: .value("Día", session.day),
                        y: .value("Cantidad", session.count)
                    )
                    .foregroundStyle(
                        session.type == "Normal" ? Color.red :
                        session.type == "Hábito" ? Color.green : Color.blue
                    )
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
        .padding()
    }
}

#Preview {
    ViewMockHome()
}

#Preview {
    ChartsComponentView()
}
