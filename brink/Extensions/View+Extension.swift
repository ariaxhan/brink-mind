//
//  View+Extension.swift
//  brink
//
//  Created by Aria Han on 12/5/24.
//

import SwiftUI

// MARK: - View Modifiers
extension View {
    /// Applies standard card styling used throughout Brink
    func brinkCard(backgroundColor: Color? = nil) -> some View {
        self.modifier(CardModifier(backgroundColor: backgroundColor))
    }
    
    /// Applies standard text input styling
    func brinkTextField() -> some View {
        self.modifier(TextFieldModifier())
    }
    
    /// Applies settings row styling
    func settingsRow() -> some View {
        self.modifier(SettingsRowModifier())
    }
    
    /// Applies standard padding used throughout the app
    func standardPadding() -> some View {
        self.padding(.horizontal, 16)
            .padding(.vertical, 12)
    }
    
    /// Applies consistent corner radius
    func brinkCornerRadius() -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Custom Modifiers
struct CardModifier: ViewModifier {
    let backgroundColor: Color?
    @Environment(\.themeColors) private var themeColors
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor ?? themeColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

struct TextFieldModifier: ViewModifier {
    @Environment(\.themeColors) private var themeColors
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(themeColors.background)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(themeColors.quaternary.opacity(0.3), lineWidth: 1)
            )
    }
}

struct SettingsRowModifier: ViewModifier {
    @Environment(\.themeColors) private var themeColors
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(themeColors.background)
            .cornerRadius(8)
    }
}

// MARK: - Navigation Bar Styling
extension View {
    func brinkNavigationBar() -> some View {
        self.modifier(NavigationBarModifier())
    }
}

struct NavigationBarModifier: ViewModifier {
    @Environment(\.themeColors) private var themeColors
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(themeColors.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

// MARK: - Conditional Modifiers
extension View {
    /// Apply modifier only if condition is met
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
