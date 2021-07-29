//
//  TasksScheduler.swift
//  Task-CoreData
//
//  Created by Ali Dinç on 29/07/2021.
//

import UserNotifications

class TasksScheduler {
    
    func clearNotifications(for task: Task) {
        guard let identifier = task.id?.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func scheduleNotification(for task: Task) {
        guard let timeOfDay = task.dueDate,
              let identifier = task.id?.uuidString else { return }
        
        clearNotifications(for: task)
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "It's time to do your \(task.name ?? Constants.task)"
        content.sound = .default
        content.userInfo = [Constants.taskID : identifier]
        content.categoryIdentifier = Constants.taskReminderCategoryIdentifier
        
        let fireDateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeOfDay)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }
    
}
