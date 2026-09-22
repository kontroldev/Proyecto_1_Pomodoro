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
    @Environment(\.scenePhase) private var scenePhase
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
                .multilineTextAlignment(.center)
                .padding(.top, 40)

            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundStyle(.gray)

                Circle()
                    .trim(from: 0.0, to: viewModel.progress)
                    .stroke(sessionType.tint, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.5), value: viewModel.timeRemaining)

                Text(timeText)
                    .font(.largeTitle)
                    .bold()
                    .monospacedDigit()
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: 260)
            .padding(.horizontal, 24)

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

            Button("Terminar y guardar") {
                viewModel.finishAndSave(type: sessionType, in: modelContext)
            }
            .disabled(viewModel.didSave || (viewModel.elapsedTime == 0 && !viewModel.isRunning))
            .buttonStyle(.bordered)

            if viewModel.didSave {
                Label("Sesión guardada", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(sessionType.displayName)
        .task(id: viewModel.isRunning) {
            guard viewModel.isRunning else { return }
            await viewModel.runCountdown()
            saveIfFinished()
        }
        .onChange(of: scenePhase) { _, newPhase in
            // Al volver a primer plano, recalcula enseguida con la hora real
            // en lugar de esperar al siguiente ciclo del bucle.
            guard newPhase == .active else { return }
            viewModel.refresh()
            saveIfFinished()
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

    private func saveIfFinished() {
        if viewModel.isFinished {
            viewModel.saveSession(type: sessionType, in: modelContext)
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
