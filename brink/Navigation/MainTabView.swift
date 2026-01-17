//
//  MainTabView.swift
//  brink
//
//  Created by Aria Han on 12/2/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    
    // Custom dark navy color
    private let darkNavy = Color(red: 0.01, green: 0.01, blue: 0.05)
    
    var body: some View {
        VStack(spacing: 0) {
            // Main content area
            ZStack {
                switch selectedTab {
                case .chat:
                    MainChatView(title: "Chat")
                case .journal:
                    JournalView()
                case .home:
                    HomeView()
                case .health:
                    DashboardView()
                case .profile:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Custom Tab Bar
            ZStack {
                Rectangle()
                    .fill(darkNavy)
                    .frame(height: 80)
                
                HStack(spacing: 0) {
                    TabBarButton(
                        unselectedIcon: "bubble.left",
                        selectedIcon: "bubble.left.fill",
                        isSelected: selectedTab == .chat
                    ) {
                        selectedTab = .chat
                    }
                    Spacer()
                    TabBarButton(
                        unselectedIcon: "pencil",
                        selectedIcon: "pencil",
                        isSelected: selectedTab == .journal
                    ) {
                        selectedTab = .journal
                    }
                    Spacer()
                    TabBarButton(
                        unselectedIcon: "house",
                        selectedIcon: "house.fill",
                        isSelected: selectedTab == .home
                    ) {
                        selectedTab = .home
                    }
                    Spacer()
                    TabBarButton(
                        unselectedIcon: "heart",
                        selectedIcon: "heart.fill",
                        isSelected: selectedTab == .health
                    ) {
                        selectedTab = .health
                    }
                    Spacer()
                    TabBarButton(
                        unselectedIcon: "person.circle",
                        selectedIcon: "person.circle.fill",
                        isSelected: selectedTab == .profile
                    ) {
                        selectedTab = .profile
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 10)
        .background(darkNavy)
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension MainTabView {
    enum Tab {
        case chat, journal, home, health, profile
    }
}

// Updated Tab Bar Button with separate icons for selected/unselected states
struct TabBarButton: View {
    let unselectedIcon: String
    let selectedIcon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isSelected ? selectedIcon : unselectedIcon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? .white : .gray)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
    }
}
