//
//  NewJournalEntryViewModel.swift
//  brink
//
//  Created by Aria Han on 1/11/25.
//

import Foundation
import SwiftUI

final class NewJournalEntryViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var currentPrompt: String = "What's on your mind today?"
    @Published var isShowingVoiceView: Bool = false
    @Published var isLoadingHealthData: Bool = false

    private let journalService: JournalService

    init(journalService: JournalService) {
        self.journalService = journalService
    }

    func refreshPrompt() {
        currentPrompt = "How are you feeling right now?"
    }

    @MainActor
    func saveEntry() {
        let newEntry = JournalEntryMO(context: journalService.context)
        newEntry.id = UUID()
        newEntry.content = "\(title)\n\(content)"
        newEntry.date = Date()
        newEntry.lastModified = Date()
        journalService.saveContext()
    }

    @MainActor
    func fetchHealthData() async {
        isLoadingHealthData = true
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        isLoadingHealthData = false
    }
}


// MinimalActionButton.swift
// brink
//
// Created by Aria Han on 1/8/25.

import SwiftUI

struct MinimalActionButton: View {
    let icon: String
    let text: String
    var isLoading: Bool = false
    let action: () -> Void
    @Environment(\.themeColors) private var themeColors
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(.subheadline, design: .rounded))
                Text(text)
                    .font(.system(.subheadline, design: .rounded))
            }
            .foregroundColor(themeColors.text.opacity(0.6))
        }
        .disabled(isLoading)
    }
}
