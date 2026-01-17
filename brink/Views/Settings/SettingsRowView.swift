//
//  SettingsRowView.swift
//  brink
//
//  Created by Aria Han on 1/15/25.
//

import SwiftUI

struct SettingsRowView: View {
    let icon: String
    let title: String
    let subtitle: String
    @Environment(\.themeColors) private var themeColors

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(themeColors.accent)
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body.weight(.medium))
                    .foregroundColor(themeColors.text)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(themeColors.textSecondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(themeColors.textSecondary) 
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(themeColors.cardBackground)
        .cornerRadius(10)
        .shadow(color: themeColors.accent.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
