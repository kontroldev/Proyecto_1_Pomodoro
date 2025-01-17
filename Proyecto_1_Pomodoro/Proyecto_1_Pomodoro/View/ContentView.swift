//
//  ContentView.swift
//  Proyecto_1_Pomodoro
//
//  Created by Raúl Gallego Alonso on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTap: TabItem = .tabHome
    var body: some View {
        ZStack(alignment: .bottom) {
                
                TabView(selection: $activeTap) {
                    ForEach(TabItem.allCases){ tab in
                        tab.view
                            .tabItem({
                                Label(tab.nameLabel, systemImage: tab.symbolIcon)
                            })
                            .tag(tab.id)
                    }
                    
                }
            InteractiveTabBar(activeTap: $activeTap)
        }
        
    }
}

#Preview {
    ContentView()
}
