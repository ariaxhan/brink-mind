//
//  HealthDataAnalysis.swift
//  brink
//
//  Created by Aria Han on 12/6/24.
//

import Foundation

@available(iOS 17.0, *)
class HealthDataAnalysis {
    /// Analyzes heart rate data.
    func analyzeHeartRate(_ samples: [HeartRateSample]) -> String {
        guard !samples.isEmpty else { return "No heart rate data available." }
        let avgHeartRate = samples.map { $0.value }.reduce(0, +) / Double(samples.count)
        return "Average heart rate: \(String(format: "%.1f", avgHeartRate)) bpm"
    }
    
    /// Analyzes step count data.
    func analyzeSteps(_ samples: [StepCountSample]) -> String {
        guard !samples.isEmpty else { return "No step count data available." }
        let totalSteps = samples.map { $0.steps }.reduce(0, +)
        return "Total steps: \(Int(totalSteps)) steps"
    }
    
    /// Analyzes exercise minutes.
    func analyzeExerciseMinutes(_ samples: [ExerciseMinutesSample]) -> String {
        guard !samples.isEmpty else { return "No exercise minutes data available." }
        let totalMinutes = samples.map { $0.minutes }.reduce(0, +)
        return "Total exercise time: \(Int(totalMinutes)) minutes"
    }
    
    /// Analyzes HRV data.
    func analyzeHRV(_ samples: [HRVSample]) -> String {
        guard !samples.isEmpty else { return "No HRV data available." }
        let avgHRV = samples.map { $0.value }.reduce(0, +) / Double(samples.count)
        return "Average HRV: \(String(format: "%.1f", avgHRV)) ms"
    }
    
    /// Analyzes sleep data.
    func analyzeSleep(_ samples: [SleepSample]) -> String {
        guard !samples.isEmpty else { return "No sleep data available." }
        let totalSleep = samples.map { $0.durationInHours }.reduce(0, +)
        return "Total sleep time: \(String(format: "%.1f", totalSleep)) hours"
    }
}
