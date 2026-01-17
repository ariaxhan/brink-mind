//
//  JournalDetailedViewModel.swift
//  brink
//
//  Created by Aria Han on 1/12/25.
//

import Foundation
import SwiftUI
import Combine

final class JournalDetailedViewModel: ObservableObject {
    @Published var title: String
    @Published var content: String
    @Published var date: Date
    @Published var healthData: Data?
    @Published var tags: [String]
    
    @Published var isDeleted: Bool = false
    @Published var isEditing: Bool = false
    @Published var showDeleteConfirmation: Bool = false
    
    public let journalEntry: JournalEntryMO
    public let journalService: JournalService

    init(entry: JournalEntryMO, journalService: JournalService) {
        self.journalEntry = entry
        self.journalService = journalService
        self.title = entry.content?.components(separatedBy: "\n").first ?? "Untitled Entry"
        self.content = entry.content ?? ""
        self.date = entry.date ?? Date()
        self.healthData = entry.healthData
        self.tags = entry.tags?.compactMap { ($0 as? TagMO)?.name } ?? []
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // MARK: - Actions
    
    @MainActor
    func deleteEntry() {
        journalService.deleteEntry(journalEntry)
        isDeleted = true
    }
    
    func startEditing() {
        isEditing = true
    }
}
