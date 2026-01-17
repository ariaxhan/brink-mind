//
//  ThemeModels.swift
//  brink
//
//  Created by Aria Han on 1/16/25.
//

import SwiftUI
import Combine

// MARK: - Color Theme Definition
extension Color {
    /// Initializes a `Color` using a hexadecimal string.
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

// MARK: - Theme Colors
struct BrinkThemeColors {
    let primary: Color
    let secondary: Color
    let tertiary: Color
    let quaternary: Color
    let quinary: Color
    let colorScheme: ColorScheme

    var background: Color { primary }
    var cardBackground: Color { secondary }
    var accent: Color { quaternary }
    var text: Color { colorScheme == .dark ? .white : .black }
    var textSecondary: Color { colorScheme == .dark ? Color.white.opacity(0.7) : Color.black.opacity(0.7) }
    var backgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [primary, quinary]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Theme Options
extension Color {
    enum BrinkTheme: String, CaseIterable {
        case system, light, dark, harper, darcy, shay, kit, zephyr, aspen

        var displayName: String {
            switch self {
            case .system: return "System"
            case .light: return "Light"
            case .dark: return "Dark"
            case .harper: return "Harper"
            case .darcy: return "Darcy"
            case .shay: return "Shay"
            case .kit: return "Kit"
            case .zephyr: return "Zephyr"
            case .aspen: return "Aspen"
            }
        }

        func colors(in colorScheme: ColorScheme? = nil) -> BrinkThemeColors {
            let scheme = colorScheme ?? .light
            switch self {
            case .system:
                return scheme == .dark ? Self.dark.colors(in: scheme) : Self.light.colors(in: scheme)
            case .light:
                return BrinkThemeColors(primary: Color(hex: "FFFFFF"), secondary: Color(hex: "F2F2F7"), tertiary: Color(hex: "E5E5EA"), quaternary: Color(hex: "007AFF"), quinary: Color(hex: "000000"), colorScheme: scheme)
            case .dark:
                return BrinkThemeColors(primary: Color(hex: "000000"), secondary: Color(hex: "1C1C1E"), tertiary: Color(hex: "2C2C2E"), quaternary: Color(hex: "0A84FF"), quinary: Color(hex: "FFFFFF"), colorScheme: scheme)
            case .harper:
                return BrinkThemeColors(primary: Color(hex: "E0EFE2"), secondary: Color(hex: "C6D8CC"), tertiary: Color(hex: "B2C6BA"), quaternary: Color(hex: "9EB7AA"), quinary: Color(hex: "8CAA99"), colorScheme: scheme)
            case .darcy:
                return BrinkThemeColors(primary: Color(hex: "F4E2EA"), secondary: Color(hex: "E0C6D8"), tertiary: Color(hex: "CCB7DB"), quaternary: Color(hex: "BCAAC9"), quinary: Color(hex: "AA96BA"), colorScheme: scheme)
            case .shay:
                return BrinkThemeColors(primary: Color(hex: "D6E5EF"), secondary: Color(hex: "B7D1E0"), tertiary: Color(hex: "A0BFCE"), quaternary: Color(hex: "89AAB7"), quinary: Color(hex: "7799A5"), colorScheme: scheme)
            case .kit:
                return BrinkThemeColors(primary: Color(hex: "FCEDE8"), secondary: Color(hex: "EDD3D1"), tertiary: Color(hex: "E2C1C6"), quaternary: Color(hex: "D8AFBA"), quinary: Color(hex: "D1A5B2"), colorScheme: scheme)
            case .zephyr:
                return BrinkThemeColors(primary: Color(hex: "CCEAE0"), secondary: Color(hex: "BFE0D8"), tertiary: Color(hex: "B2D6D1"), quaternary: Color(hex: "E0CCBF"), quinary: Color(hex: "EADDD1"), colorScheme: scheme)
            case .aspen:
                return BrinkThemeColors(primary: Color(hex: "E2CEB5"), secondary: Color(hex: "CCB299"), tertiary: Color(hex: "BAA087"), quaternary: Color(hex: "AA9177"), quinary: Color(hex: "9E846B"), colorScheme: scheme)
            }
        }
    }
}
