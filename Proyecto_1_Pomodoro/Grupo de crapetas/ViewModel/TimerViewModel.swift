//
//  TimerViewModel.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 8/3/25.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int
    @Published var isRunning: Bool = false
    private var timer: Timer?
    
    init(initialTime: Int = 1500) { // 25 minutos
        self.timeRemaining = initialTime
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
        timeRemaining = 1500 // Reinicia a 25 min
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
    }
}
