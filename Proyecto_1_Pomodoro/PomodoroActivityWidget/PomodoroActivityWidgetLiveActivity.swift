//
//  PomodoroActivityWidgetLiveActivity.swift
//  PomodoroActivityWidget
//
//  Created by Manuel Bermudo on 26/1/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PomodoroActivityWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var timeRemaining: Int
        var isBreak: Bool
        var progress: CGFloat
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PomodoroActivityWidgetLiveActivity: Widget {

    var vm = TimerViewModel()

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PomodoroActivityWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text(context.state.isBreak ? "Descanso" : "Trabajo")
                    .font(.largeTitle)
                    .foregroundColor(context.state.isBreak ? .blue : .green)
                Text("Tiempo restante: \(formatTime(seconds: context.state.timeRemaining))")
                    .font(.largeTitle)
                    .bold()
                ProgressView(value: context.state.progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .red))
                    .scaleEffect(x: 1, y: 2, anchor: .center)
            }
            .padding()

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                }
                DynamicIslandExpandedRegion(.trailing) {
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack{
                        Text(context.state.isBreak ? "Descanso☕️" : "Trabajo ⏰")
                            .foregroundColor(context.state.isBreak ? .blue : .green)
                            .font(.title)
                        Text(formatTime(seconds: context.state.timeRemaining))
                            .font(.largeTitle)
                            .bold()
                        ProgressView(value: context.state.progress, total: 1.0)
                            .progressViewStyle(LinearProgressViewStyle(tint: .gray)) // La barra se vuelve gris para "borrar"
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.red) // Fondo rojo detrás
                            )
                            .scaleEffect(x: -1, y: 2, anchor: .center) // Invierte la dirección
                            .padding(.horizontal, 10)
                            .offset(y: -6)
                    }
                }
            } compactLeading: {
                Text(context.state.isBreak ? "Descanso" : "Trabajo")
                    .foregroundColor(context.state.isBreak ? .blue : .green)
            } compactTrailing: {
                Text(formatTime(seconds: context.state.timeRemaining))
            } minimal: {
                Text(context.state.isBreak ? "☕️" : "⏰")
            }
        }
    }
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

extension PomodoroActivityWidgetAttributes {
    fileprivate static var preview: PomodoroActivityWidgetAttributes {
        PomodoroActivityWidgetAttributes(name: "World")
    }
}

extension PomodoroActivityWidgetAttributes.ContentState {
    fileprivate static var smiley: PomodoroActivityWidgetAttributes.ContentState {
        PomodoroActivityWidgetAttributes.ContentState(timeRemaining: 1, isBreak: false, progress: 0.5)
     }
     
     fileprivate static var starEyes: PomodoroActivityWidgetAttributes.ContentState {
         PomodoroActivityWidgetAttributes.ContentState(timeRemaining: 1, isBreak: false, progress: 0.5)
     }
}

#Preview("Notification", as: .content, using: PomodoroActivityWidgetAttributes.preview) {
   PomodoroActivityWidgetLiveActivity()
} contentStates: {
    PomodoroActivityWidgetAttributes.ContentState.smiley
    PomodoroActivityWidgetAttributes.ContentState.starEyes
}
