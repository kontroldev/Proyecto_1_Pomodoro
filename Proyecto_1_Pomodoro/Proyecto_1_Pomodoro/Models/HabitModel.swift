//
//  HabitModel.swift
//  Proyecto_1_Pomodoro
//
//  Created by Jacob Aguilar on 22-01-25.
//

import Foundation
import SwiftData

@Model
class HabitModel: Identifiable, Hashable {
    @Attribute(.unique) var identifier: UUID
    var name: String
    var startedAt: Date
    var dedicatedTimeInSeconds: Int
    @Relationship(deleteRule: .cascade) var sessions: [PomodoroSessionModel]
    @Relationship(deleteRule: .cascade) var tasks: [TaskModel]
    
    init(identifier: UUID = UUID(), name: String, startedAt: Date, dedicatedTimeInSeconds: Int, sessions: [PomodoroSessionModel] = [], tasks: [TaskModel]) {
        self.identifier = identifier
        self.name = name
        self.startedAt = startedAt
        self.dedicatedTimeInSeconds = dedicatedTimeInSeconds
        self.sessions = sessions
        self.tasks = tasks
    }
}

@Model
class PomodoroSessionModel: Identifiable, Hashable {
    @Attribute(.unique) var identifier: UUID
    var name: String
    var targetTimeInSeconds: Int
    var dedicatedTimeInSeconds: Int
    var createdAt: Date
    var restTargetTime: Int
    @Relationship(deleteRule: .nullify) var habit: HabitModel?
    
    init(identifier: UUID = UUID(), name: String, targetTimeInSeconds: Int, dedicatedTimeInSeconds: Int, createdAt: Date, restTargetTime: Int, habit: HabitModel? = nil) {
        self.identifier = identifier
        self.name = name
        self.targetTimeInSeconds = targetTimeInSeconds
        self.dedicatedTimeInSeconds = dedicatedTimeInSeconds
        self.createdAt = createdAt
        self.restTargetTime = restTargetTime
        self.habit = habit
    }
}

@Model
class TaskModel: Identifiable, Hashable {
    @Attribute(.unique) var identifier: UUID
    var title: String
    var isCompleted: Bool
    @Relationship(deleteRule: .nullify) var habit: HabitModel?
    
    init(identifier: UUID = UUID(), title: String, isCompleted: Bool, habit: HabitModel? = nil) {
        self.identifier = identifier
        self.title = title
        self.isCompleted = isCompleted
        self.habit = habit
    }
}
