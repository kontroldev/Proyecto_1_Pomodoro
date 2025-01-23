//
//  DatabaseService.swift
//  Proyecto_1_Pomodoro
//
//  Created by Jacob Aguilar on 22-01-25.
//

import Foundation
import SwiftData

@MainActor
class DatabaseService {
    static let shared = DatabaseService()
    
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private init() { }
    
    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: HabitModel.self, PomodoroSessionModel.self, TaskModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            print(error.localizedDescription)
            fatalError("Database couldn't be created")
        }
    }
    
    // MARK: - Habit Methods
    func createHabit(name: String, startedAt: Date, dedicatedTimeInSeconds: Int) -> HabitModel {
        let habit = HabitModel(name: name, startedAt: startedAt, dedicatedTimeInSeconds: dedicatedTimeInSeconds, tasks: [TaskModel](), isFavorite: false)
        container.mainContext.insert(habit)
        saveContext()
        
        return habit
    }

    func fetchAllHabits() -> [HabitModel] {
        let request = FetchDescriptor<HabitModel>()
        
        do {
            return try  container.mainContext.fetch(request)
        } catch {
            print("Error fetching habits: \(error)")
            return []
        }
    }

    func updateHabit(habit: HabitModel, name: String? = nil, dedicatedTimeInSeconds: Int? = nil, isFavorite: Bool) {
        if let name = name {
            habit.name = name
        }
        
        if let dedicatedTimeInSeconds = dedicatedTimeInSeconds {
            habit.dedicatedTimeInSeconds = dedicatedTimeInSeconds
        }
        
        habit.isFavorite = isFavorite
        
        saveContext()
    }

    func deleteHabit(habit: HabitModel) {
        container.mainContext.delete(habit)
        
        saveContext()
    }

    // MARK: - Pomodoro Session Methods
    func createPomodoroSession( name: String, targetTimeInSeconds: Int, dedicatedTimeInSeconds: Int, createdAt: Date, restTargetTime: Int, habit: HabitModel) -> PomodoroSessionModel {
        let session = PomodoroSessionModel(
            name: name,
            targetTimeInSeconds: targetTimeInSeconds,
            dedicatedTimeInSeconds: dedicatedTimeInSeconds,
            createdAt: createdAt,
            restTargetTime: restTargetTime,
            habit: habit
        )
        
        container.mainContext.insert(session)
        saveContext()
        
        return session
    }

    func fetchSessions(forHabit habit: HabitModel) -> [PomodoroSessionModel] {
        return habit.sessions
    }

    func updatePomodoroSession(session: PomodoroSessionModel, name: String? = nil, dedicatedTimeInSeconds: Int? = nil) {
        if let name = name {
            session.name = name
        }
        
        if let dedicatedTimeInSeconds = dedicatedTimeInSeconds {
           
            session.dedicatedTimeInSeconds = dedicatedTimeInSeconds
        }
        saveContext()
    }

    func deletePomodoroSession(session: PomodoroSessionModel) {
        container.mainContext.delete(session)
        
        saveContext()
    }

    // MARK: - Task Methods
    func createTask(title: String, isCompleted: Bool, habit: HabitModel) -> TaskModel {
        let task = TaskModel(title: title, isCompleted: isCompleted, habit: habit)
        container.mainContext.insert(task)
        saveContext()
        return task
    }

    func fetchTasks(forHabit habit: HabitModel) -> [TaskModel] {
        return habit.tasks
    }

    func updateTask(task: TaskModel, title: String? = nil, isCompleted: Bool? = nil) {
        if let title = title {
            task.title = title
        }
        
        if let isCompleted = isCompleted {
            task.isCompleted = isCompleted
        }
        
        saveContext()
    }

    func deleteTask(task: TaskModel) {
        container.mainContext.delete(task)
        saveContext()
    }

    
    // MARK: - Save Context
    private func saveContext() {
        do {
            try  container.mainContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
