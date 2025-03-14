//
//  PomodoroTimerView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 8/3/25.
//

import SwiftUI

struct PomodoroTimerView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var timeRemaining: Int
    @State private var isRunning: Bool = false
    @State private var timer: Timer? = nil

    let totalTime: Int = 1500
    let selectedTime: Int
    let sessionType: String = "Pomodoro"

    init(selectedTime: Int) {
        self.selectedTime = selectedTime
        self._timeRemaining = State(initialValue: selectedTime)
    }

    var progress: CGFloat {
        return CGFloat(timeRemaining) / CGFloat(totalTime)
    }

    var body: some View {
        VStack {
            Text("Temporizador")
                .font(.largeTitle)
                .bold()
                .padding()

            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                    .frame(width: 200, height: 200)

                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(Color.red, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200, height: 200)
                    .animation(.linear(duration: 1), value: progress)

                Text(timeString(from: timeRemaining))
                    .font(.largeTitle)
                    .bold()
            }
            .padding()

            HStack(spacing: 20) {
                Button(action: startTimer) {
                    Text("Iniciar")
                        .padding()
                        .background(isRunning ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(isRunning)

                Button(action: pauseTimer) {
                    Text("Pausar")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: resetTimer) {
                    Text("Reiniciar")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }

    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                isRunning = false
            }
        }
    }

    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
    }

    // Reinicia el temporizador
    func resetTimer() {
        // Paramos el temporizador si está en marcha
        isRunning = false
        timer?.invalidate()

        // Creamos una nueva sesión Pomodoro con la duración y tipo actual
        let session = PomodoroSessionModel(date: Date(), duration: selectedTime, type: sessionType)
        
        // Insertamos la sesión en el contexto de SwiftData
        modelContext.insert(session)
        
        // Intentamos guardar los cambios en el modelo de datos
        try? modelContext.save()
        
        // Volvemos a establecer el tiempo restante al tiempo inicial seleccionado
        timeRemaining = selectedTime
    }

    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
