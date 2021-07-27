//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Ali Dinç on 27/07/2021.
//

import CoreData

class TaskController {
    
    // MARK: - Properties
    static let shared = TaskController()
    
    var tasks = [Task]()
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private init() { }
    
    // MARK: - CRUD Methods
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        self.tasks = tasks
    }
    
    func update(task: Task, name: String, notes: String?, date: Date = Date()) {
        task.name = name
        task.notes = notes
        task.dueDate = date
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }
}
