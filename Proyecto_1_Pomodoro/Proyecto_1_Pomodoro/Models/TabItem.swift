//
//  Untitled.swift
//  Proyecto_1_Pomodoro
//
//  Created by Esteban Pérez Castillejo on 16/1/25.
//


import Foundation
import SwiftUI

enum TabItem: CaseIterable, Identifiable {
    case tabHome
    case tabListTask
    case tabTimer
    case tabSetting
    
    var id: Self {self}
    
    // nombre del label
    var nameLabel: String {
        switch self {
            
        case .tabHome:
            return "Home"
        case .tabListTask:
            return "List task"
        case .tabTimer:
            return "Pomodoro"
        case .tabSetting:
            return "Setting"
        }
    }
  
    // Nombre de los Iconos SFSymbols
    var symbolIcon: String {
        switch self {
        case .tabHome:
            return "house.fill"
        case .tabListTask:
            return "list.triangle"
        case .tabTimer:
            return "clock.arrow.trianglehead.counterclockwise.rotate.90"
        case .tabSetting:
            return "gearshape.fill"
        }
    }
    
    // Las vista que llamara el tab
    var view: AnyView {
        switch self{
            
        case .tabHome:
            return AnyView(ViewMockHome())
        case .tabListTask:
            return AnyView(ViewMockList())
        case .tabTimer:
            return AnyView(ViewMockTimer())
        case .tabSetting:
            return AnyView(ViewMockSetting())
        }
    }
    
    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}
