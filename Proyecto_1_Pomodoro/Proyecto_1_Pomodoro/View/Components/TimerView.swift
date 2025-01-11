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
    }
}

struct TimerView: View {

    @State private var progress: CGFloat = 1.0  // Progreso inicial
    @State private var timeRemaining: Int = 60  // Tiempo restante
    @State private var playPressed = false // Botón presionado
    @State private var pausePressed = false // Botón presionado
    let totalTime: Int = 60  // Tiempo total del temporizador

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(Color(#colorLiteral(red: 0.6215203404, green: 0.002358516213, blue: 0.002240711823, alpha: 1)), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: progress)

                Text(formatTime(seconds: timeRemaining))
                    .font(.largeTitle)
                    .bold()
            }
            .frame(width: 200, height: 200)
            .padding(.bottom, 40)

            HStack{
                IconButton(symbolName: "play.fill", isPressed: playPressed){
                    playPressed.toggle()
                    if pausePressed {pausePressed.toggle()}
                }
                IconButton(symbolName: "pause.fill", isPressed: pausePressed){
                    pausePressed.toggle()
                    if playPressed {playPressed.toggle()}
                }
                IconButton(symbolName: "arrow.counterclockwise", isPressed: false){
                }
            }
        }
    }
    // Función para formatear el tiempo en formato 00:00
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

#Preview {
    TimerView()
}
