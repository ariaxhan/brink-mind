//
//  JournalVoiceService.swift
//  brink
//
//  Created by Aria Han on 1/8/25.
//


//
//  JournalVoiceService.swift
//  brink
//
//  Created by Aria Han on 12/6/24.
//

import SwiftUI
import Combine
import AVFAudio
import os.log

@MainActor
class JournalVoiceService: ObservableObject {
    @Published var transcribedText = ""
    @Published var inputLevel: CGFloat = 0.0
    @Published var isProcessing = false
    @Published var recordingError: RecordingService.RecordingError?
    @Published var errorMessage: String?

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.brink", category: "JournalVoiceService")
    private var subscriptions = Set<AnyCancellable>()

    /// The same `RecordingService` you already have in the project
    var recordingService: RecordingService

    init(recordingService: RecordingService) {
        self.recordingService = recordingService
        logger.log("JournalVoiceService initialization started")
        setupSubscriptions()
        logger.log("JournalVoiceService initialized successfully")
    }

    private func setupSubscriptions() {
        logger.log("Setting up subscriptions for JournalVoiceService")

        // Subscribe to input level updates
        recordingService.$inputLevel
            .receive(on: RunLoop.main)
            .assign(to: &$inputLevel)

        // Subscribe to transcribed text updates
        recordingService.$transcribedText
            .receive(on: RunLoop.main)
            .assign(to: &$transcribedText)

        // Handle errors from the recording service
        recordingService.$recordingError
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let error = error {
                    self?.logger.error("Recording error: \(error.localizedDescription)")
                    self?.errorMessage = "Recording error occurred: \(error.localizedDescription)"
                } else {
                    self?.errorMessage = nil
                }
            }
            .store(in: &subscriptions)

        logger.log("Subscriptions setup completed for JournalVoiceService")
    }
}
