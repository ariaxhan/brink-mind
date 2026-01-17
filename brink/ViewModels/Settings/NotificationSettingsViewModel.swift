//
//  NotificationSettingsViewModel.swift
//  brink
//
//  Created by Aria Han on 1/13/25.
//

import SwiftUI
import UserNotifications

class NotificationSettingsViewModel: ObservableObject {
    @Published var notificationPermissionStatus: UNAuthorizationStatus = .notDetermined
    @Published var showingPermissionAlert = false
    
    func updateNotificationPermissionStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationPermissionStatus = settings.authorizationStatus
            }
        }
    }

    func requestNotificationPermission() {
        NotificationPermissionsManager.shared.requestNotificationAuthorization { granted, error in
            DispatchQueue.main.async {
                if granted {
                    self.updateNotificationPermissionStatus()
                } else {
                    self.showingPermissionAlert = true
                }
            }
        }
    }

    func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
    
    var permissionStatusIcon: String {
        switch notificationPermissionStatus {
        case .authorized: return "bell.badge.fill"
        case .denied: return "bell.slash.fill"
        default: return "bell.fill"
        }
    }

    var permissionStatusColor: Color {
        switch notificationPermissionStatus {
        case .authorized: return .green
        case .denied: return .red
        default: return .gray
        }
    }

    var permissionStatusTitle: String {
        switch notificationPermissionStatus {
        case .authorized: return "Notifications Enabled"
        case .denied: return "Notifications Disabled"
        default: return "Enable Notifications"
        }
    }

    var permissionStatusDescription: String {
        switch notificationPermissionStatus {
        case .authorized: return "You'll receive updates about your wellness journey."
        case .denied: return "Enable notifications to stay updated."
        default: return "Allow notifications to get wellness insights."
        }
    }
}
