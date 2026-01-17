//
//  AudioPermissionsManager.swift
//  brink
//
//  Created by Aria Han on 12/4/24.
//

import AVFoundation
import Speech

final class AudioPermissionsManager {
    static let shared = AudioPermissionsManager()

    private init() {}

    /// Requests microphone permissions and returns whether permission was granted.
    func requestMicrophonePermissions() async -> Bool {
        return await withCheckedContinuation { continuation in
            if #available(iOS 17.0, *) {
                AVAudioApplication.requestRecordPermission { granted in
                    continuation.resume(returning: granted)
                }
            } else {
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    continuation.resume(returning: granted)
                }
            }
        }
    }

    /// Requests speech recognition permissions and returns whether permission was granted.
    func requestSpeechRecognitionPermissions() async -> Bool {
        return await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }

}
