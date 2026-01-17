//
//  DeveloperSettingsViewModel.swift
//  brink
//
//  Created by Aria Han on 1/13/25.
//

import SwiftUI

class DeveloperSettingsViewModel: ObservableObject {
    @Published var showingAPIKeySheet: Bool = false
    @Published var apiKey: String
    @Published var showingResetConfirmation: Bool = false
    
    @EnvironmentObject private var userModel: UserModel
    
    init() {
        apiKey = UserDefaults.standard.string(forKey: "apiKey") ?? ""
    }
    
    func saveAPIKey(_ key: String) {
        apiKey = key
        UserDefaults.standard.set(apiKey, forKey: "apiKey")
    }
    
    func resetDeveloperSettings() {
        userModel.developerSettings = DeveloperSettings()
        apiKey = ""
        UserDefaults.standard.removeObject(forKey: "apiKey")
    }
}
