//
//  HomeModels.swift
//  brink
//
//  Created by Aria Han on 1/9/25.
//

// Insight.swift

import SwiftUI

struct Trend: Identifiable {
    let id = UUID()
    let title: String
    var value: String
    let iconName: String
    let color: Color
}

struct AIJournalInsight: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let description: String
    let colorGradient: [Color]
}


struct DesignConstants {
    static let spacing: CGFloat = 40
    static let horizontalPadding: CGFloat = 24
    static let verticalPadding: CGFloat = 32
    static let gridSpacing: CGFloat = 16
    static let cardPadding: CGFloat = 20
    static let timelineMarkerSize: CGFloat = 12
    static let maxTagsToShow = 2
}
