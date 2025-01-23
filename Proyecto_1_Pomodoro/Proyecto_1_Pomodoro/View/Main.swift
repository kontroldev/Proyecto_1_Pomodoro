//
//  Main.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 18/1/25.
//

import SwiftUI

struct MainView: View {
    var username: String = "Nombre de Usuario" // Puedes cambiar este valor según el usuario
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
          
                Text("Bienvenido, \(username)!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("¿Qué te apetece hacer hoy?")
                    .font(.headline)
                
                HStack(spacing: 20) {
                    MainButtonView(title: "Trabajo", color: .orange, action: {
                        print("Botón Trabajo presionado")
                    })
                    MainButtonView(title: "Estudio", color: .blue, action: {
                        print("Botón Estudio presionado")
                    })
                    MainButtonView(title: "Ocio", color: .red, action: {
                        print("Botón Ocio presionado")
                    })
                }
                .padding(.vertical, 20)
                
                
                // Los tres botones del medio
                // Para cambiar el destino de los botones: Moldels -> ItemMenu
                
                ScrollView{
                    ForEach(menuItem){buttonItems in
                        NavigationLink(destination: buttonItems.mainButtonlink){
                            HStack{
                                
                                Text(buttonItems.mainButtonText)
                                    .font(.system(size: 17).bold())
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                             
                                Image(systemName: buttonItems.mainButtonIco)
                                    .font(.title.bold())
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .frame(width: 300, height: 41)
                            .padding(20)
                            .background(Color(buttonItems.mainButtonColor))
                            .cornerRadius(15)
                            .foregroundColor(Color.white)
                            .padding(8)
                        }
                    }
                }
                
                Spacer()
                
      
            }
            .padding()
            .navigationTitle("Pantalla Principal")
        }
    }
}

struct MainButtonView: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 100, height: 50)
                .background(color)
                .cornerRadius(10)
        }
    }
}

#Preview {
    MainView()
}
