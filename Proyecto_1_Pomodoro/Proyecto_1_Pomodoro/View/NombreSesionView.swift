//
//  NombreSesion.swift
//  Proyecto_1_Pomodoro
//
//  Created by Alejandro Gabriel Soriano Palomino on 11/01/25.
//

import SwiftUI

struct NombreSesionView: View {
    
    let times : [String] = ["25:00","30:00","60:00"]
    let titTexField : [String] = ["Temporizador personalizado", "Modo actual", "Temporizador pausa"]
    var body: some View {
        NavigationStack {
            VStack(){
                    //Textfield Nombre Sesion
                    CustomTextField(titulo: "Nombre sesión")
                    
                    //Botones tiempo
                    Text("Tiempo")
                    .font(.headline)
                    .padding()
                    
                    //HSTACK con botones de tiempo
                    HStack (spacing: 10){
                    ForEach(times,id:\.self){item in DefaultTimeButtonView(time: item,action: {})}
                    }
                    .padding(.leading)
                    
                    //Textfield
                    ForEach(titTexField,id:\.self){i in CustomTextField(titulo: i)}

                
            }
            .navigationTitle("Nombre de la sesión")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            //Botón Iniciar sesión
            StartSessionButtonView(action: {})
        }
    }
}

struct CustomTextField: View {
    var titulo: String
    @State var texto: String = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            Text(titulo)
                .font(.headline)
            TextField("",text: $texto)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
        .padding()
    }
}

#Preview {
    NombreSesionView()
}
