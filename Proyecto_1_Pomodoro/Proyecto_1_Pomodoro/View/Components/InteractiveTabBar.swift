//
//  InteractiveTabBar.swift
//  Proyecto_1_Pomodoro
//
//  Created by Esteban Pérez Castillejo on 16/1/25.
//

import SwiftUI

struct InteractiveTabBar: View {
    @Binding var activeTap: TabItem
    
    @Environment(\.colorScheme) var scheme
    @Namespace private var animation
    
    @State private var tabButtonLocations: [CGRect] = Array(repeating: .zero, count: TabItem.allCases.count)
    @State private var activeDraggingTab: TabItem?
    
    var body: some View {
        HStack(spacing: 0){
            ForEach(TabItem.allCases) { tab in
                tab_Buttons(tab)
            }
        }
        .frame(height: 70)
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
        .background{
            Rectangle()
                .fill(Color.white.shadow(.drop( color: .primary.opacity(0.5), radius: 5)))
                .ignoresSafeArea()
                .padding(.top, 20)
        }
        .coordinateSpace(.named("TABBAR"))
    }
    
    @ViewBuilder
    func tab_Buttons(_ tab: TabItem) -> some View {
        let isActive = (activeDraggingTab ?? activeTap) == tab
        
        VStack(spacing: 10){
            Image(systemName: tab.symbolIcon)
                .symbolVariant(.fill)
                .foregroundStyle( scheme == .dark ? .white : .primary)
                .frame(width: isActive ? 50 : 25 , height: isActive ? 50 : 25)
                .background{
                    
                    if isActive {
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .overlay(content: {
                                Circle()
                                    .trim(from: 0.0, to: 1.0)
                                    .stroke(RadialGradient(colors: [scheme == .dark ? .white : .black.opacity(0.4), Color.white.opacity(0.001)], center: .top, startRadius: 0, endRadius: 100), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                                    .frame(width: 50, height: 50)
                                    .opacity(1.0)
                                    .rotationEffect(.degrees(90)) .blur(radius: 8)
                                    .clipShape(
                                        Circle()
                                            .stroke( style: StrokeStyle(lineWidth: 5, lineCap: .butt, dash: [100,80], dashPhase: 100))
                                    )
                            })
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
                .contentShape(.rect)
                .gesture(
                    DragGesture(coordinateSpace: .named("TABBAR"))
                        .onChanged{ value in
                            let location = value.location
                            
                            if let index = tabButtonLocations.firstIndex(where: {$0.contains(location)}){
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)){
                                    activeDraggingTab = TabItem.allCases[index]
                                }
                            }
                        }.onEnded{_ in
                            if let activeDraggingTab {
                                activeTap =  activeDraggingTab
                            }
                            
                            activeDraggingTab = nil
                        },
                    
                    
                    isEnabled: activeTap == tab
                )
                .frame(width: 25, height: 25, alignment: .bottom)
            
                .foregroundStyle(scheme == .dark ?  .black : .white )
            
            Text(tab.nameLabel).font(.caption2)
                .foregroundStyle(isActive ? .blue : .gray)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .onGeometryChange(for: CGRect.self, of: {
            $0.frame(in: .named("TABBAR"))
        }, action: { newValue in
            tabButtonLocations[tab.index] = newValue
        })
        .contentShape(.rect)
        .onTapGesture {
            withAnimation(.spring){
                activeTap = tab
            }
        }
    }
    
}

//#Preview {
//    InteractiveTabBar()
//}
