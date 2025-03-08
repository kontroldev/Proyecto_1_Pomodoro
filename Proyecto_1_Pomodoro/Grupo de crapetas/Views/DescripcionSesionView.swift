//
//  DescripcionSesionView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 8/3/25.
//

import SwiftUI

struct DescripcionSesionView: View {
    @Binding var selectedTime: Int
    let defaultTimes = [1500, 1800, 2100] // 25, 30, 35 minutos

    var body: some View {
        VStack {
            Text("Elige la duración de tu sesión")
                .font(.title)
                .padding()

            HStack {
                ForEach(defaultTimes, id: \.self) { time in
                    Button(action: {
                        DispatchQueue.main.async {
                            selectedTime = time
                        }
                    }) {
                        Text("\(time / 60) min")
                            .padding()
                            .background(selectedTime == time ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()

            // Picker para seleccionar un tiempo personalizado
            Picker("Selecciona tiempo", selection: $selectedTime) {
                ForEach(1...120, id: \.self) { minutes in
                    Text("\(minutes) min").tag(minutes * 60)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)

            NavigationLink(destination: TimerView(selectedTime: selectedTime)) {
                Text("Confirmar y empezar")
                    .padding()
                    .background(selectedTime > 0 ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(selectedTime <= 0) // Evitar navegar sin seleccionar un tiempo
            .padding()
        }
        .navigationTitle("Configurar sesión")
    }
}

#Preview {
    DescripcionSesionView(selectedTime: .constant(1500))
}
