//
//  ViewMockHome.swift
//  Proyecto_1_Pomodoro
//
//  Created by Esteban Pérez Castillejo on 16/1/25.
//

import SwiftUI

 
struct ViewMockHome: View {
    var body: some View {
        
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            
            Text("Home").font(.title.bold())
        }
    }
}

struct ViewMockList: View {
    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            
            Text("List task").font(.title.bold())
        }
    }
}


struct ViewMockTimer: View {
    var body: some View {
        ZStack {
            Color.pink
                .ignoresSafeArea()
            
            Text("Pomodoro 500").font(.title.bold())
        }
    }
}

struct ViewMockSetting: View {
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            
            Text("Setting").font(.title.bold())
        }
    }
}


#Preview {
    ViewMockHome()
}
