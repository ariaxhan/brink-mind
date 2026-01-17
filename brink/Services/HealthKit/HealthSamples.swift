//
//  HealthSamples.swift
//  brink
//
//  Created by Aria Han on 12/5/24.
//

import Foundation

protocol HealthSample: Identifiable, Codable {
    var id: UUID { get }
    var startDate: Double { get }
    var endDate: Double { get }
}

struct HeartRateSample: HealthSample {
    let id: UUID
    let value: Double
    let startDate: Double
    let endDate: Double
    
    init(id: UUID = UUID(), value: Double, startDate: Date, endDate: Date) {
        self.id = id
        self.value = value
        self.startDate = startDate.timeIntervalSince1970
        self.endDate = endDate.timeIntervalSince1970
    }
}

struct StepCountSample: HealthSample {
    let id: UUID
    let steps: Double
    let startDate: Double
    let endDate: Double
    
    init(id: UUID = UUID(), steps: Double, startDate: Date, endDate: Date) {
        self.id = id
        self.steps = steps
        self.startDate = startDate.timeIntervalSince1970
        self.endDate = endDate.timeIntervalSince1970
    }
}

struct ExerciseMinutesSample: HealthSample {
    let id: UUID
    let minutes: Double
    let startDate: Double
    let endDate: Double
    
    init(id: UUID = UUID(), minutes: Double, startDate: Date, endDate: Date) {
        self.id = id
        self.minutes = minutes
        self.startDate = startDate.timeIntervalSince1970
        self.endDate = endDate.timeIntervalSince1970
    }
}

struct HRVSample: HealthSample {
    let id: UUID
    let value: Double
    let startDate: Double
    let endDate: Double
    
    init(id: UUID = UUID(), value: Double, startDate: Date, endDate: Date) {
        self.id = id
        self.value = value
        self.startDate = startDate.timeIntervalSince1970
        self.endDate = endDate.timeIntervalSince1970
    }
}

struct SleepSample: HealthSample {
    let id: UUID
    let startDate: Double
    let endDate: Double
    let stage: String
    let value: Int
    
    var durationInHours: Double {
        (endDate - startDate) / 3600
    }
    
    init(id: UUID = UUID(), startDate: Date, endDate: Date, stage: String, value: Int) {
        self.id = id
        self.startDate = startDate.timeIntervalSince1970
        self.endDate = endDate.timeIntervalSince1970
        self.stage = stage
        self.value = value
    }
}
//
//  HealthSamples.swift
//  brink
//
//  Created by Aria Han on 12/6/24.
//

