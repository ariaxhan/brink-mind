//
//  brinkApp.swift
//  brink
//
//  Created by Aria Han on 12/2/24.
//

import SwiftUI
import CoreData

@main
struct brinkApp: App {
    @StateObject private var userModel = UserModel()
    @StateObject private var themeState = BrinkThemeState()
    @Environment(\.colorScheme) private var colorScheme
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(userModel)
                .environmentObject(themeState)
                .modifier(ThemeModifier(themeState: themeState))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


