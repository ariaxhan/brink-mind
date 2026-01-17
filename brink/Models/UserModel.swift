//
//  UserModel.swift
//  brink
//
//  Created by Aria Han on 12/5/24.
//


import Foundation
import SwiftUI

// MARK: - User Model
class UserModel: ObservableObject {
    @Published var profile: UserProfile
    @Published var preferences: UserPreferences
    @Published var privacySettings: PrivacySettings
    @Published var developerSettings: DeveloperSettings
    
    init() {
        self.profile = UserProfile()
        self.preferences = UserPreferences()
        self.privacySettings = PrivacySettings()
        self.developerSettings = DeveloperSettings()
        
        loadFromUserDefaults()
    }
}

// MARK: - Profile
struct UserProfile: Codable {
    var name: String = ""
    var email: String = ""
    var dateJoined: Date = Date()
    var lastActive: Date = Date()
    var uuid: String = UUID().uuidString
    var password: String = ""
}

// MARK: - Preferences
struct UserPreferences: Codable {
    // Theme and Display
    var theme: String = "harper"  // Default theme
    var isDarkMode: Bool = false
    var useSystemTheme: Bool = true
    var textSize: TextSize = .medium
    var reduceAnimations: Bool = false
    var hapticFeedback: Bool = true
    var language: String = "en"
    
    enum TextSize: String, Codable, CaseIterable {
        case small, medium, large
    }
}

// MARK: - Privacy Settings
struct PrivacySettings: Codable {
    var healthKitEnabled: Bool = false
    var shareBiometrics: Bool = false
    var shareJournalAnalytics: Bool = false
    var allowDataCollection: Bool = true
    var autoBackup: Bool = true
    var syncAcrossDevices: Bool = true
}

// MARK: - Developer Settings
struct DeveloperSettings: Codable {
    var debugMode: Bool = false
    var showPerformanceMetrics: Bool = false
    var verboseLogging: Bool = false
    var useTestEnvironment: Bool = false
    var showHiddenFeatures: Bool = false
    
    // API Settings
    var apiEnvironment: APIEnvironment = .production
    var customAPIEndpoint: String = ""
    
    enum APIEnvironment: String, Codable, CaseIterable {
        case production, staging, development
    }
}

// MARK: - UserDefaults Extension
extension UserModel {
    private func loadFromUserDefaults() {
        if let profileData = UserDefaults.standard.data(forKey: "userProfile"),
           let profile = try? JSONDecoder().decode(UserProfile.self, from: profileData) {
            self.profile = profile
        }
        
        if let preferencesData = UserDefaults.standard.data(forKey: "userPreferences"),
           let preferences = try? JSONDecoder().decode(UserPreferences.self, from: preferencesData) {
            self.preferences = preferences
        }
        
        if let privacyData = UserDefaults.standard.data(forKey: "privacySettings"),
           let privacy = try? JSONDecoder().decode(PrivacySettings.self, from: privacyData) {
            self.privacySettings = privacy
        }
        
        if let developerData = UserDefaults.standard.data(forKey: "developerSettings"),
           let developer = try? JSONDecoder().decode(DeveloperSettings.self, from: developerData) {
            self.developerSettings = developer
        }
    }
    
    func saveToUserDefaults() {
        if let profileData = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(profileData, forKey: "userProfile")
        }
        
        if let preferencesData = try? JSONEncoder().encode(preferences) {
            UserDefaults.standard.set(preferencesData, forKey: "userPreferences")
        }
        
        if let privacyData = try? JSONEncoder().encode(privacySettings) {
            UserDefaults.standard.set(privacyData, forKey: "privacySettings")
        }
        
        if let developerData = try? JSONEncoder().encode(developerSettings) {
            UserDefaults.standard.set(developerData, forKey: "developerSettings")
        }
    }
}
