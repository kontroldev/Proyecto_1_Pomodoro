//
//  SessionSetupView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raul Gallego Alonso on 8/3/25.
//

import SwiftUI

struct SessionSetupView: View {
    @Binding var selectedTime: Int

    private let defaultTimes = [1500, 1800, 2100]

    var body: some View {
        VStack {
            Text("Elige la duracion de tu sesion")
                .font(.title)
                .padding()

            HStack {
                ForEach(defaultTimes, id: \.self) { time in
                    Button("\(time / 60) min") {
                        selectedTime = time
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(selectedTime == time ? .blue : .gray)
                }
            }
            .padding()

            Picker("Selecciona tiempo", selection: $selectedTime) {
                ForEach(1...120, id: \.self) { minutes in
                    Text("\(minutes) min").tag(minutes * 60)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)

            NavigationLink {
                TimerView(selectedTime: selectedTime)
            } label: {
                Text("Confirmar y empezar")
            }
            .disabled(selectedTime <= 0)
            .buttonStyle(.borderedProminent)
            .tint(selectedTime > 0 ? .green : .gray)
            .padding()
        }
        .navigationTitle("Configurar sesion")
    }
}

#Preview {
    NavigationStack {
        SessionSetupView(selectedTime: .constant(1500))
    }
}
