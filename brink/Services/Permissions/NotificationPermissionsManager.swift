//
//  NotificationPermissionsManager.swift
//  brink
//
//  Created by Aria Han on 1/13/25.
//

import Foundation
import UserNotifications

class NotificationPermissionsManager {
    static let shared = NotificationPermissionsManager()
    
    private init() {}
    
    // Request Notification authorization
    func requestNotificationAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false, error)
                } else {
                    completion(granted, granted ? nil : NotificationError.authorizationDenied)
                }
            }
        }
    }
    
    // Check current notification settings
    func checkNotificationSettings(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus == .authorized)
            }
        }
    }
    
    // Schedule a simple notification
    func scheduleNotification(title: String, body: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            }
        }
    }
}

enum NotificationError: LocalizedError {
    case authorizationDenied
    
    var errorDescription: String? {
        switch self {
        case .authorizationDenied:
            return "Notification authorization was denied."
        }
    }
}
