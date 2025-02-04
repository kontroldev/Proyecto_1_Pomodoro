//
//  TimerViewModel.swift
//  Proyecto_1_Pomodoro
//
//  Created by Matias Alvarez on 16/1/25.
//

import SwiftUI
import ActivityKit

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
        max(0, (isBreak ? breakLength : length) - timeElapsed) //Modificado por @ManuelCBR para que timeElapsed no sigua incrementándose después de haber alcanzado el límite de tiempo
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
                    updateLiveActivity() //Actualiza la isla dinámica
                } else {
                    

                   /* pauseTimer()
                }
            }
        }
    }*/
                    switchTimerMode()
                    self.updateLiveActivity() //Actualiza la isla dinámica
                    
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

    //Para la isla dinámica ----------------------------
    func updateLiveActivity() {
            guard let activity = Activity<PomodoroActivityWidgetAttributes>.activities.first else {
                print("No hay una Live Activity activa.")
                return
            }

            let contentState = PomodoroActivityWidgetAttributes.ContentState(
                timeRemaining: timeRemaining,
                isBreak: isBreak,
                progress: progress
            )

            Task {
                await activity.update(using: contentState)
            }
        print("Live Activity actualizada: \(contentState.timeRemaining) segundos restantes.")
        }

        func startLiveActivity() {
            guard ActivityAuthorizationInfo().areActivitiesEnabled else {
                print("Live Activities no están habilitadas en este dispositivo.")
                return
            }

            let attributes = PomodoroActivityWidgetAttributes(name: "Pomodoro Timer")
            let initialContentState = PomodoroActivityWidgetAttributes.ContentState(
                timeRemaining: timeRemaining,
                isBreak: isBreak,
                progress: progress
            )

            do {
                _ = try Activity.request(
                    attributes: attributes,
                    contentState: initialContentState,
                    pushType: nil
                )
                print("Live Activity iniciada.")
            } catch {
                print("Error al iniciar Live Activity: \(error)")
            }
        }
    //------------------------------------------------------------
    
}
