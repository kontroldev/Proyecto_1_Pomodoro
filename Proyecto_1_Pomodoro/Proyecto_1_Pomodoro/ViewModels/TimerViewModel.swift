//
//  TimerViewModel.swift
//  Proyecto_1_Pomodoro
//
//  Created by Matias Alvarez on 16/1/25.
//

import SwiftUI

@Observable
final class TimerViewModel: @unchecked Sendable {
    
    var length: Int
    
    init(length: Int = 60) {
        self.length = length
    }

    var isTimerRunning = false
    var timeElapsed = 0
    var timer: Timer? = nil
    
    
    var timeRemaining: Int {
        length - timeElapsed
    }

    var progress: CGFloat {
        CGFloat(length - timeRemaining) / CGFloat(length)
    }
    
    var playPressed: Bool {
        guard timeRemaining > 0, !isTimerRunning else { return true }
        return false
    }
    
    var pausePressed: Bool {
        guard timeRemaining > 0, isTimerRunning else { return true }
        return false
    }
    
    var resetPressed: Bool {
        guard timeRemaining != length, !isTimerRunning else { return true }
        return false
    }
    
    func playTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            Task { @MainActor in
                if timeRemaining > 0 {
                    timeElapsed += 1
                } else {
                    pauseTimer()
                }
            }
        }
    }
    
    func pauseTimer() {
        isTimerRunning = false
        timer?.invalidate()
    }
    
    func resetTimer() {
        timeElapsed = 0
        isTimerRunning = false
    }
}
