//
//  ProfileSettingsViewModel.swift
//  brink
//
//  Created by Aria Han on 1/13/25.
//

import Foundation
import SwiftUI

class ProfileSettingsViewModel: ObservableObject {
    @Published var profile: UserProfile
    @Published var isEditing: Bool = false
    @Published var showingDeleteAlert: Bool = false
    @Published var showingPasswordChange: Bool = false
    
    private let userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
        self.profile = userModel.profile
    }
    
    func toggleEditing() {
        if isEditing {
            userModel.profile = profile
            userModel.saveToUserDefaults()
        }
        isEditing.toggle()
    }
    
    func updateProfile(name: String? = nil, email: String? = nil) {
        if let name = name { profile.name = name }
        if let email = email { profile.email = email }
    }
    
    func deleteAccount() {
        // Handle account deletion logic here
    }
    
    func accountAge() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: profile.dateJoined, relativeTo: Date())
    }
}
