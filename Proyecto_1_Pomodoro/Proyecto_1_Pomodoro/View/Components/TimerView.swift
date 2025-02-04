//
//  TimerView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Manuel Bermudo on 10/1/25.
//

import SwiftUI

//Componente para los botones
struct IconButton: View {
    let symbolName: String
    let isPressed: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: symbolName)
                .foregroundColor(Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))) // Color del icono
                .font(.system(size: 30, weight: .heavy)) // Tamaño y grosor del icono
                .frame(width: 50, height: 50) // Tamaño del área del botón
                .background(isPressed ? Color(#colorLiteral(red: 0.3903380632, green: 0.4003468752, blue: 0.946198523, alpha: 1)) : Color(#colorLiteral(red: 0.3154583275, green: 0.3055469394, blue: 0.3057260513, alpha: 1))) // Color de fondo
                .clipShape(RoundedRectangle(cornerRadius: 10)) // Forma redondeada
                .padding(.horizontal, 10)
        }
        .disabled(isPressed)
    }
}

struct TimerView: View {

    @State private var progress: CGFloat = 1.0
    @State private var playPressed = false
    @State private var pausePressed = false


    /*@State private var progress: CGFloat = 1.0  // Progreso inicial
    @State private var timeRemaining: Int = 60  // Tiempo restante
    @State private var playPressed = false // Botón presionado
    @State private var pausePressed = false // Botón presionado
    let totalTime: Int = 60  // Tiempo total del temporizador*/

  
    
    let vm: TimerViewModel

    var body: some View {
        VStack {
            Text(vm.isBreak ? "Descanso" : "Trabajo")
                .font(.title)
                .bold()
                .foregroundColor(vm.isBreak ? .cyan : .green)
                .padding(.bottom, 20)

            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                Circle()
                    .trim(from: 0.0, to: vm.progress)

                    .stroke(vm.isBreak ? Color.blue : Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))


               //     .stroke(Color(#colorLiteral(red: 0.6215203404, green: 0.002358516213, blue: 0.002240711823, alpha: 1)), style: StrokeStyle(lineWidth: 20, lineCap: .round))

                   


                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: vm.progress)

                Text(formatTime(seconds: vm.timeRemaining))
                    .font(.largeTitle)
                    .bold()
            }
            .frame(width: 200, height: 200)
            .padding(.bottom, 40)


            HStack {
                IconButton(symbolName: "play.fill", isPressed: vm.isTimerRunning) {
                    vm.playTimer()
                    vm.startLiveActivity()
                }
                IconButton(symbolName: "pause.fill", isPressed: !vm.isTimerRunning) {
                    vm.pauseTimer()
                }
                IconButton(symbolName: "arrow.counterclockwise", isPressed: vm.resetPressed) {


     /*       HStack{
                IconButton(symbolName: "play.fill", isPressed: vm.playPressed){
                    vm.playTimer()
                }
                IconButton(symbolName: "pause.fill", isPressed: vm.pausePressed){
                    vm.pauseTimer()
                }
                IconButton(symbolName: "arrow.counterclockwise", isPressed: vm.resetPressed){*/

                    vm.resetTimer()
                }
            }
        }
    }

    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
}

#Preview {
    
    TimerView(vm: TimerViewModel(length: 5, breakLength: 5)) // 25 minutos de trabajo, 5 de descanso
    
    
    //  TimerView(vm: TimerViewModel(length: 30))
    
}

