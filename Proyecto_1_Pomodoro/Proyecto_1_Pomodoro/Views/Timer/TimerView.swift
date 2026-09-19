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
    @State private var viewModel: TimerViewModel

    private let sessionType: SessionType

    init(selectedTime: Int, sessionType: SessionType = .pomodoro) {
        self.sessionType = sessionType
        _viewModel = State(initialValue: TimerViewModel(initialTime: selectedTime))
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Temporizador \(sessionType.displayName)")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)

            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundStyle(.gray)
                    .frame(width: 220, height: 220)

                Circle()
                    .trim(from: 0.0, to: viewModel.progress)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 220, height: 220)
                    .animation(.linear(duration: 0.5), value: viewModel.timeRemaining)

                Text(timeText)
                    .font(.largeTitle)
                    .bold()
                    .monospacedDigit()
            }

            HStack(spacing: 16) {
                Button("Iniciar") {
                    viewModel.start()
                }
                .disabled(viewModel.isRunning || viewModel.isFinished)
                .buttonStyle(.borderedProminent)
                .tint(viewModel.isRunning ? .gray : .green)

                Button("Pausar") {
                    viewModel.pause()
                }
                .disabled(!viewModel.isRunning)
                .buttonStyle(.borderedProminent)
                .tint(.orange)

                Button("Reiniciar") {
                    viewModel.reset()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }

            Button("Guardar sesion") {
                viewModel.saveSession(type: sessionType, in: modelContext)
            }
            .disabled(viewModel.didSave || viewModel.elapsedTime == 0)
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .navigationTitle(sessionType.displayName)
        .task(id: viewModel.isRunning) {
            guard viewModel.isRunning else { return }
            await viewModel.runCountdown()
            if viewModel.isFinished {
                viewModel.saveSession(type: sessionType, in: modelContext)
            }
        }
        .alert(
            "No se pudo guardar la sesión",
            isPresented: errorAlertBinding,
            presenting: viewModel.saveErrorMessage
        ) { _ in
            Button("OK") {}
        } message: { message in
            Text(message)
        }
    }

    private var timeText: String {
        Duration.seconds(viewModel.timeRemaining)
            .formatted(.time(pattern: .minuteSecond(padMinuteToLength: 2)))
    }

    private var errorAlertBinding: Binding<Bool> {
        Binding(
            get: { viewModel.saveErrorMessage != nil },
            set: { isPresented in
                if !isPresented { viewModel.dismissSaveError() }
            }
        )
    }
}

#Preview {
    NavigationStack {
        TimerView(selectedTime: 1500)
    }
    .modelContainer(for: PomodoroSessionModel.self, inMemory: true)
}
