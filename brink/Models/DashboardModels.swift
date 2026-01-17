//
//  DashboardModels.swift
//  brink
//
//  Created by Aria Han on 1/12/25.
//

import SwiftUICore

enum HealthTrend {
    case up, down, stable
}

struct MetricData: Identifiable {
    let id = UUID()
    let value: Double
    let unit: String
    let name: String
    let trend: HealthTrend
}

enum HealthPatternType {
    case primary, bodyResponse, sleepConnection, movementConnection
    
    var title: String {
        switch self {
        case .primary: return "Primary Pattern"
        case .bodyResponse: return "Body Response"
        case .sleepConnection: return "Sleep Connection"
        case .movementConnection: return "Movement Connection"
        }
    }
    
    var icon: Image {
        switch self {
        case .primary: return Image(systemName: "star.fill")
        case .bodyResponse: return Image(systemName: "waveform.path.ecg")
        case .sleepConnection: return Image(systemName: "bed.double.fill")
        case .movementConnection: return Image(systemName: "figure.walk")
        }
    }
}

struct HealthPattern: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let metrics: [MetricData]
    let type: HealthPatternType
}
