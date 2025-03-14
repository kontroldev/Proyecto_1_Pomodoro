import SwiftUI
import Combine
import SwiftData

class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int
    @Published var isRunning: Bool = false
    private var timer: Timer?
    private var modelContext: ModelContext? // ❗Ahora es opcional
    let initialTime: Int

    init(initialTime: Int = 1500) {
        self.timeRemaining = initialTime
        self.initialTime = initialTime
    }

    // ✅ Ahora puedes inyectar modelContext después
    func setModelContextIfNeeded(_ context: ModelContext) {
        self.modelContext = context
    }

    func startTimer() {
        guard !isRunning else { return }
        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
            }
        }
    }

    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
    }

    func resetTimer() {
        pauseTimer()
        timeRemaining = initialTime
    }

    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
    }

    func saveSession(type: String) {
        guard let context = modelContext else { return }
        let session = PomodoroSessionModel(date: Date(), duration: initialTime, type: type)
        context.insert(session)

        do {
            try context.save()
        } catch {
            print("❌ Error al guardar la sesión Pomodoro: \(error.localizedDescription)")
        }
    }
}
