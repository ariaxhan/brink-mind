//
//  JournalViewModel.swift
//  brink
//
//  Created by Aria Han on 1/11/25.
//

import SwiftUI
import CoreData

@MainActor
class JournalViewModel: ObservableObject {
    @Published var showingNewEntry = false
    @Published var selectedTag: String? = nil
    @Published var selectedViewOption: ViewOption = .gridCollage
    
    @Published var entries: [JournalEntryMO] = []
    var journalService: JournalService?
    
    init() {
        Task { @MainActor in
            let context = PersistenceController.shared.container.viewContext
            self.journalService = JournalService(context: context)
            fetchEntries()
        }
    }
    
    var allTags: [String]? {
        guard let entries = journalService?.entries else { return nil }
        let tags = entries
            .compactMap { $0.tags as? Set<TagMO> }
            .flatMap { $0 }
            .compactMap { $0.name }
        
        let uniqueTags = Set(tags)
        return uniqueTags.isEmpty ? nil : Array(uniqueTags).sorted()
    }
    
    func fetchEntries() {
        journalService?.fetchEntries()
        entries = journalService?.entries ?? []
    }
    
    func toggleNewEntrySheet() {
        showingNewEntry.toggle()
    }
}

// ViewOption Enum
enum ViewOption {
    case gridCollage
    case timelineScroll
}

