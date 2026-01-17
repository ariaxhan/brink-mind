//
//  PrivacySettingsViewModel.swift
//  brink
//
//  Created by Aria Han on 1/13/25.
//

import SwiftUI
import HealthKit
import SwiftUI
import HealthKit

class PrivacySettingsViewModel: ObservableObject {
    @Published var showingDeleteConfirmation = false
    @Published var showingExportSheet = false
    @Published var healthKitAuthorizationError: String? = nil
    @Published var isProcessingAuthorization: Bool = false
    @Published var showRevokePermissionGuide: Bool = false  // Trigger for guide

    @EnvironmentObject private var userModel: UserModel

    func requestHealthKitAuthorization(completion: @escaping (Bool) -> Void) {
        HealthPermissionsManager.shared.requestHealthKitAuthorization { success, _ in
            completion(success)
        }
    }

    /// Simulate revoking HealthKit access and show the step-by-step guide
    func revokeHealthKitPermissions() {
        showRevokePermissionGuide = true
    }

    func handleDeleteAccount() {
        // Implement account deletion logic
    }

    func handleExportData() {
        showingExportSheet = true
    }
}
