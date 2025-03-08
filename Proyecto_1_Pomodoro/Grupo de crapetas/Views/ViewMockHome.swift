//
//  ViewMockHome.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 8/3/25.
//

import SwiftUI

struct ViewMockHome: View {
    @State private var selectedTime: Int = 1500 // Se inicializa con 25 minutos

    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenido a Pomodoro")
                    .font(.title)
                    .padding()

                NavigationLink(destination: DescripcionSesionView(selectedTime: $selectedTime)) {
                    Text("Iniciar Pomodoro")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Inicio")
        }
    }
}

#Preview {
    ViewMockHome()
}
