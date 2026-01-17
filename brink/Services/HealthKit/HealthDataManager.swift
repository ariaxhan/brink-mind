//
//  HealthDataManager.swift
//  brink
//
//  Created by Aria Han on 12/5/24.
//

import Foundation
import os.log

@available(iOS 17.0, *)
class HealthDataManager {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.brink", category: "HealthDataManager")
    private let fetchers: [HealthMetric: Any] = [
        .heartRate: HeartRateFetcher(),
        .steps: StepCountFetcher(),
        .exerciseMinutes: ExerciseMinutesFetcher(),
        .hrv: HRVFetcher(),
        .sleep: SleepFetcher()
    ]
    private let analysis = HealthDataAnalysis()
    
    func fetchAndAnalyzeAllData(from startDate: Date, to endDate: Date) async -> [HealthMetric: String] {
        var results: [HealthMetric: String] = [:]
        
        for metric in HealthMetric.allCases {
            do {
                switch metric {
                case .heartRate:
                    if let fetcher = fetchers[.heartRate] as? HeartRateFetcher {
                        let samples = try await fetcher.fetchHeartRateData(from: startDate, to: endDate)
                        results[.heartRate] = analysis.analyzeHeartRate(samples)
                    }
                case .steps:
                    if let fetcher = fetchers[.steps] as? StepCountFetcher {
                        let samples = try await fetcher.fetchStepCountData(from: startDate, to: endDate)
                        results[.steps] = analysis.analyzeSteps(samples)
                    }
                case .exerciseMinutes:
                    if let fetcher = fetchers[.exerciseMinutes] as? ExerciseMinutesFetcher {
                        let samples = try await fetcher.fetchExerciseMinutesData(from: startDate, to: endDate)
                        results[.exerciseMinutes] = analysis.analyzeExerciseMinutes(samples)
                    }
                case .hrv:
                    if let fetcher = fetchers[.hrv] as? HRVFetcher {
                        let samples = try await fetcher.fetchHRVData(from: startDate, to: endDate)
                        results[.hrv] = analysis.analyzeHRV(samples)
                    }
                case .sleep:
                    if let fetcher = fetchers[.sleep] as? SleepFetcher {
                        let samples = try await fetcher.fetchSleepData(from: startDate, to: endDate)
                        results[.sleep] = analysis.analyzeSleep(samples)
                    }
                }
            } catch {
                logger.error("Failed to fetch or analyze \(metric.displayName): \(error.localizedDescription)")
                results[metric] = "Error: \(error.localizedDescription)"
            }
        }
        
        return results
    }
}
