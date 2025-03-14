//
//  TimerView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 9/3/25.
//

import SwiftUI
import SwiftData

/// Vista principal que muestra el temporizador Pomodoro
struct TimerView: View {
    @Environment(\.modelContext) private var modelContext

    // Tiempo seleccionado para la sesión Pomodoro (en segundos)
    private var selectedTime: Int

    // ViewModel que gestiona la lógica del temporizador
    @StateObject private var viewModel: TimerViewModel

    /// Inicializador que recibe el tiempo seleccionado desde la vista anterior.
    /// - Parameter selectedTime: Tiempo en segundos (ejemplo: 1500 para 25 minutos)
    init(selectedTime: Int) {
        self.selectedTime = selectedTime
        // El ViewModel se crea con el tiempo seleccionado
        _viewModel = StateObject(wrappedValue: TimerViewModel(initialTime: selectedTime))
    }

    var body: some View {
        VStack(spacing: 20) {
            // Título principal
            Text("Temporizador Pomodoro")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)

            // Círculo de progreso visual
            ZStack {
                // Círculo de fondo
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 200)

                // Círculo de progreso animado
                Circle()
                    .trim(from: 0.0, to: progressValue())
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200, height: 200)
                    .animation(.linear(duration: 0.5), value: viewModel.timeRemaining)

                // Tiempo restante en el centro del círculo
                Text(formatTime(viewModel.timeRemaining))
                    .font(.largeTitle)
                    .bold()
            }

            // Botones de control
            HStack(spacing: 20) {
                // Iniciar
                Button("Iniciar") {
                    viewModel.startTimer()
                }
                .disabled(viewModel.isRunning)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                // Pausar
                Button("Pausar") {
                    viewModel.pauseTimer()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)

                // Reiniciar
                Button("Reiniciar") {
                    viewModel.resetTimer()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            // Asignar el contexto de SwiftData cuando aparece la vista
            viewModel.setModelContextIfNeeded(modelContext)
        }
    }

    // MARK: - Funciones auxiliares

    /// Calcula el progreso del círculo (valor entre 0.0 y 1.0)
    private func progressValue() -> CGFloat {
        return CGFloat(viewModel.timeRemaining) / CGFloat(viewModel.initialTime)
    }

    /// Formatea el tiempo restante en formato mm:ss
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerView(selectedTime: 1500)
}
