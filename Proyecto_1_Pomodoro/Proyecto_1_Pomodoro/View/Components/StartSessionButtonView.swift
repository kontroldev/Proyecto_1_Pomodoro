//
//  StartSessionButtonView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Jacob on 10-01-25.
//

import SwiftUI

struct StartSessionButtonView: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            
        } label: {
            Text("Iniciar sesión")
                .foregroundStyle(.white)
                .frame(width: 180, height: 12)
                .padding()
                .background(Color("StartSessionButtonColor"))
                .containerShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    StartSessionButtonView(action: {})
}
