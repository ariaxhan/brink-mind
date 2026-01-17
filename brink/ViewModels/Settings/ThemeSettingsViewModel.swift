//
//  ThemeSettingsViewModel.swift
//  brink
//
//  Created by Aria Han on 1/13/25.
//

import SwiftUI
import Combine

class ThemeSettingsViewModel: ObservableObject {
    @Published var selectedTheme: Color.BrinkTheme {
        didSet {
            if oldValue != selectedTheme {
                updateTheme(to: selectedTheme)
            }
        }
    }
    
    @Published var textSize: UserPreferences.TextSize {
        didSet {
            if oldValue != textSize {
                userModel.preferences.textSize = textSize
            }
        }
    }
    
    @Published var reduceAnimations: Bool {
        didSet {
            if oldValue != reduceAnimations {
                userModel.preferences.reduceAnimations = reduceAnimations
            }
        }
    }
    
    @Published var hapticFeedback: Bool {
        didSet {
            if oldValue != hapticFeedback {
                userModel.preferences.hapticFeedback = hapticFeedback
            }
        }
    }

    private var userModel: UserModel
    private var themeState: BrinkThemeState

    init(userModel: UserModel, themeState: BrinkThemeState) {
        self.userModel = userModel
        self.themeState = themeState
        
        self.selectedTheme = themeState.current
        self.textSize = userModel.preferences.textSize
        self.reduceAnimations = userModel.preferences.reduceAnimations
        self.hapticFeedback = userModel.preferences.hapticFeedback
    }
    
    private func updateTheme(to theme: Color.BrinkTheme) {
        themeState.change(to: theme)
        userModel.preferences.theme = theme.rawValue
    }

    // MARK: - Public Methods
    func changeTheme(to theme: Color.BrinkTheme) {
        selectedTheme = theme
    }

    func updateTextSize(to size: UserPreferences.TextSize) {
        textSize = size
    }

    func toggleReduceAnimations() {
        reduceAnimations.toggle()
    }

    func toggleHapticFeedback() {
        hapticFeedback.toggle()
    }
}
