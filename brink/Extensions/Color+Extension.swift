//
//  Color+Extension.swift
//  brink
//
//  Created by Aria Han on 12/5/24.
//

import SwiftUI
import Combine

// MARK: - Theme State
class BrinkThemeState: ObservableObject {
    @Published private(set) var current: Color.BrinkTheme
    @Published private(set) var currentColors: BrinkThemeColors

    init() {
        let savedTheme = UserDefaults.standard.string(forKey: "userTheme")
        let initialTheme = Color.BrinkTheme(rawValue: savedTheme ?? "") ?? .system
        let initialColorScheme: ColorScheme = UIScreen.main.traitCollection.userInterfaceStyle == .dark ? .dark : .light

        self.current = initialTheme
        self.currentColors = initialTheme.colors(in: initialColorScheme)
    }

    func change(to theme: Color.BrinkTheme) {
        guard current != theme else { return }
        current = theme
        UserDefaults.standard.set(theme.rawValue, forKey: "userTheme")
        updateColors()
    }

    func updateColors(with colorScheme: ColorScheme? = nil) {
        let scheme = colorScheme ?? (UIScreen.main.traitCollection.userInterfaceStyle == .dark ? .dark : .light)
        currentColors = current.colors(in: scheme)
    }
}

// MARK: - Theme Colors Environment Key
private struct ThemeColorsKey: EnvironmentKey {
    static let defaultValue = Color.BrinkTheme.system.colors()
}

extension EnvironmentValues {
    var themeColors: BrinkThemeColors {
        get { self[ThemeColorsKey.self] }
        set { self[ThemeColorsKey.self] = newValue }
    }
}

struct ThemeModifier: ViewModifier {
    @ObservedObject var themeState: BrinkThemeState
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .environment(\.themeColors, themeState.current.colors(in: colorScheme))
            .onChange(of: colorScheme) { newScheme in
                if themeState.current == .system {
                    themeState.updateColors(with: newScheme)
                }
            }
    }
}

struct ThemeDebugView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.themeColors) var colors
    @ObservedObject var themeState: BrinkThemeState
    
    var body: some View {
        VStack {
            Text("Current Theme: \(themeState.current.displayName)")
                .foregroundColor(colors.text)
            Text("Color Scheme: \(colorScheme == .dark ? "Dark" : "Light")")
                .foregroundColor(colors.text)
            Text("Text Color: \(colors.text == .white ? "White" : "Black")")
                .foregroundColor(colors.text)
        }
        .padding()
        .background(colors.background)
    }
}
