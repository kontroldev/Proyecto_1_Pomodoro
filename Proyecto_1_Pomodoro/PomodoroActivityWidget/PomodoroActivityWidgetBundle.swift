//
//  PomodoroActivityWidgetBundle.swift
//  PomodoroActivityWidget
//
//  Created by Manuel Bermudo on 26/1/25.
//

import WidgetKit
import SwiftUI

@main
struct PomodoroActivityWidgetBundle: WidgetBundle {
    var body: some Widget {
        PomodoroActivityWidget()
        PomodoroActivityWidgetControl()
        PomodoroActivityWidgetLiveActivity()
    }
}
