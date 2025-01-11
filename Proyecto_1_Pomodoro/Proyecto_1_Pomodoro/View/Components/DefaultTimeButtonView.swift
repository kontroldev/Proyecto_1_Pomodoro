//
//  DefaultTimeButtonView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Jacob on 10-01-25.
//

import SwiftUI

struct DefaultTimeButtonView: View {
    var time: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(time)
                .foregroundStyle(.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color("DefaultTimerButtonColor"))
                }
        }
    }
}

#Preview {
    DefaultTimeButtonView(time: "60:00", action: {})
}
