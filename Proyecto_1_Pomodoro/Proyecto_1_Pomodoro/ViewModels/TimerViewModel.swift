//
//  TimerViewModel.swift
//  Proyecto_1_Pomodoro
//
//  Created by Matias Alvarez on 16/1/25.
//

import SwiftUI

@Observable
final class TimerViewModel: @unchecked Sendable {


    
/*    var length: Int
    
    init(length: Int = 60) {
        self.length = length

*/

    var length: Int
    var breakLength: Int
    var isBreak = false

    init(length: Int = 1500, breakLength: Int = 300) { // 25 minutos de trabajo, 5 de descanso
        self.length = length
        self.breakLength = breakLength

    }

    var isTimerRunning = false
    var timeElapsed = 0
    var timer: Timer? = nil

    
    
   /* var timeRemaining: Int {
        length - timeElapsed
    }

    var progress: CGFloat {
        CGFloat(length - timeRemaining) / CGFloat(length)
    }*/
    



    var timeRemaining: Int {
        (isBreak ? breakLength : length) - timeElapsed
    }

    var progress: CGFloat {
        let totalLength = isBreak ? breakLength : length
        return CGFloat(totalLength - timeRemaining) / CGFloat(totalLength)
    }


    var playPressed: Bool {
        guard timeRemaining > 0, !isTimerRunning else { return true }
        return false
    }

    var pausePressed: Bool {
        guard timeRemaining > 0, isTimerRunning else { return true }
        return false
    }

    
  /*  var resetPressed: Bool {
        guard timeRemaining != length, !isTimerRunning else { return true }
        return false
    }*/
    


    var resetPressed: Bool {
        guard timeElapsed > 0, !isTimerRunning else { return true }
        return false
    }


    func playTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            Task { @MainActor in
                if timeRemaining > 0 {
                    timeElapsed += 1
                } else {


                   /* pauseTimer()
                }
            }
        }
    }*/
    


                    switchTimerMode()
                }
            }
        }
    }


    func pauseTimer() {
        isTimerRunning = false
        timer?.invalidate()
    }

    
  /*  func resetTimer() {
        timeElapsed = 0
        isTimerRunning = false*/



    func resetTimer() {
        timeElapsed = 0
        isTimerRunning = false
        isBreak = false
    }

    private func switchTimerMode() {
        pauseTimer()
        timeElapsed = 0
        isBreak.toggle() // Cambia entre trabajo y descanso

    }
    
    
}
