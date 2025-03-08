//
//  TimerView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 8/3/25.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel: TimerViewModel

    init(selectedTime: Int) {
        _viewModel = StateObject(wrappedValue: TimerViewModel(initialTime: selectedTime))
    }

    var body: some View {
        VStack {
            Text(timeString(from: viewModel.timeRemaining))
                .font(.system(size: 60, weight: .bold, design: .monospaced))
                .padding()

            HStack {
                Button(action: { viewModel.startTimer() }) {
                    Text("Iniciar")
                        .padding()
                        .background(viewModel.isRunning ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: { viewModel.pauseTimer() }) {
                    Text("Pausar")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: { viewModel.resetTimer() }) {
                    Text("Reiniciar")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Temporizador")
    }

    // Formatear el tiempo en mm:ss
    func timeString(from totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerView(selectedTime: 1500)
}
