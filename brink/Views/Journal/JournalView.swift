//
//  JournalView.swift
//  brink
//
//  Created by Aria Han on 12/6/24.
//

import SwiftUI

struct JournalView: View {
    @Environment(\.themeColors) private var themeColors
    @StateObject private var viewModel = JournalViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // View Switcher
                Picker("", selection: $viewModel.selectedViewOption) {
                    Text("Grid").tag(ViewOption.gridCollage)
                    Text("Timeline").tag(ViewOption.timelineScroll)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.horizontal, .top], 20)
                .padding(.bottom, 8)
                
                // Content
                if viewModel.selectedViewOption == .gridCollage {
                    if let journalService = viewModel.journalService {
                        GridCollageView(
                            journalService: journalService,
                            selectedTag: $viewModel.selectedTag
                        )
                    }
                } else {
                    if let journalService = viewModel.journalService {
                        TimelineScrollView(
                            journalService: journalService,
                            selectedTag: $viewModel.selectedTag,
                            tags: viewModel.allTags
                        )
                    }
                }
            }
            .background(themeColors.background.ignoresSafeArea())
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.toggleNewEntrySheet() }) {
                        Image(systemName: "plus")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(themeColors.accent)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showingNewEntry) {
            if let journalService = viewModel.journalService {
                NewJournalEntryView(journalService: journalService)
            }
        }
        .onAppear {
            Task { await viewModel.fetchEntries() }
        }
    }
}
