//
//  TimerView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 9/3/25.
//

import SwiftUI
import SwiftData

struct TimerView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: TimerViewModel

    private let selectedTime: Int
    private let sessionType: String

    init(selectedTime: Int, sessionType: String = "Pomodoro") {
        self.selectedTime = selectedTime
        self.sessionType = sessionType
        _viewModel = StateObject(wrappedValue: TimerViewModel(initialTime: selectedTime))
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Temporizador \(sessionType)")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)

            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                    .frame(width: 220, height: 220)

                Circle()
                    .trim(from: 0.0, to: progressValue)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 220, height: 220)
                    .animation(.linear(duration: 0.5), value: viewModel.timeRemaining)

                Text(formatTime(viewModel.timeRemaining))
                    .font(.largeTitle)
                    .bold()
            }

            HStack(spacing: 16) {
                Button("Iniciar") {
                    viewModel.startTimer()
                }
                .disabled(viewModel.isRunning)
                .buttonStyle(.borderedProminent)
                .tint(viewModel.isRunning ? .gray : .green)

                Button("Pausar") {
                    viewModel.pauseTimer()
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)

                Button("Reiniciar") {
                    viewModel.resetTimer()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }

            Button("Guardar sesion") {
                viewModel.saveSession(type: sessionType)
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .navigationTitle(sessionType)
        .onAppear {
            viewModel.setModelContextIfNeeded(modelContext)
        }
    }

    private var progressValue: CGFloat {
        guard selectedTime > 0 else { return 0 }
        return CGFloat(viewModel.timeRemaining) / CGFloat(selectedTime)
    }

    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    NavigationStack {
        TimerView(selectedTime: 1500)
    }
    .modelContainer(for: PomodoroSessionModel.self, inMemory: true)
}
