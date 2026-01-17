//
//  HealthMetric.swift
//  brink
//
//  Created by Aria Han on 12/5/24.
//

import SwiftUI

enum HealthMetric: String, CaseIterable, Codable {
    case heartRate = "heart_rate"
    case steps = "steps"
    case exerciseMinutes = "exercise_minutes"
    case hrv = "hrv"
    case sleep = "sleep"

    var displayName: String {
        switch self {
        case .heartRate: return "Heart Rate"
        case .steps: return "Steps"
        case .exerciseMinutes: return "Exercise Minutes"
        case .hrv: return "Heart Rate Variability"
        case .sleep: return "Sleep"
        }
    }
    
    var iconName: String {
        switch self {
        case .heartRate: return "heart.fill"
        case .steps: return "figure.walk"
        case .exerciseMinutes: return "figure.run"
        case .hrv: return "waveform.path.ecg"
        case .sleep: return "bed.double.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .heartRate: return .red
        case .steps: return .green
        case .exerciseMinutes: return .orange
        case .hrv: return .purple
        case .sleep: return .blue
        }
    }
}
