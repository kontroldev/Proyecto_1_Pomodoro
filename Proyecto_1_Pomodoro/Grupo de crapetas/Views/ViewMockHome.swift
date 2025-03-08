//
//  ViewMockHome.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 8/3/25.
//

import SwiftUI

struct ViewMockHome: View {
    @State private var selectedTime: Int? = nil
    @State private var showSessionTypeSelection = false
    @State private var customTime: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Bienvenido a Pomodoro")
                    .font(.title)
                    .padding()

                // Botones para seleccionar el tiempo
                HStack {
                    ForEach([25, 30, 35], id: \.self) { time in
                        Button(action: {
                            selectedTime = time * 60
                            customTime = ""
                        }) {
                            Text("\(time) min")
                                .padding()
                                .frame(width: 80)
                                .background(selectedTime == time * 60 ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.bottom, 2) // Reducción de la separación

                // Campo de selección para tiempo personalizado (en vez de TextField)
                Picker("Tiempo personalizado", selection: $selectedTime) {
                    ForEach(1...120, id: \.self) { minute in
                        Text("\(minute) min").tag(minute * 60)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 100)

                // Botón para iniciar Pomodoro
                Button(action: {
                    if selectedTime != nil || (Int(customTime) ?? 0) > 0 {
                        showSessionTypeSelection = true
                    }
                }) {
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

                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 250, height: 150)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Inicio")
        }
        .sheet(isPresented: $showSessionTypeSelection) {
            SessionTypeSelectionView(selectedTime: $selectedTime)
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

#Preview {
    ViewMockHome()
}
