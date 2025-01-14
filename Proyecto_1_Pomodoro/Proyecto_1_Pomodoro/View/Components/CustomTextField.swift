//
//  CustomTextField.swift
//  Proyecto_1_Pomodoro
//
//  Created by Juito on 14/1/25.
//

import SwiftUI

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
    CustomTextField(titulo: "Texto")
}
