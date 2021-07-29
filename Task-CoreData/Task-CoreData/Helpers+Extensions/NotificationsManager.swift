//
//  NotificationsManager.swift
//  Task-CoreData
//
//  Created by Ali Dinç on 28/07/2021.
//

import UserNotifications


class NotificationManager: NSObject {
    
    static let shared = NotificationManager()
    
     func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { authorized, error in
            
            if authorized {
                UNUserNotificationCenter.current().delegate = self
                self.setNotificationCategories()
            } else {
                if let error = error {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
    
    private func setNotificationCategories() {
        let markCompleteAction = UNNotificationAction(identifier: Constants.markCompleteNotificationActionIdentifier, title: Constants.complete, options: UNNotificationActionOptions(rawValue: 0))
        
        let ignoreAction = UNNotificationAction(identifier: Constants.ignoreNotificationActionIdentifier, title: Constants.ignore, options: UNNotificationActionOptions(rawValue: 0))
        
        let taskActionsCategory = UNNotificationCategory(identifier: Constants.notificationCategoryIdentifier, actions: [markCompleteAction, ignoreAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        
        UNUserNotificationCenter.current().setNotificationCategories([taskActionsCategory])
    }
}


extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        NotificationCenter.default.post(name: NSNotification.Name(Constants.reminderReceivedNotificationName), object: nil)
        completionHandler([.sound, .banner])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == Constants.markCompleteNotificationActionIdentifier,
           let taskID = response.notification.request.content.userInfo[Constants.taskID] as? String {
            print("Marked as completed \(taskID)")
            completionHandler()
        }
    }
}
