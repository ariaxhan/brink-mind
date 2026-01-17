//
//  ExerciseMinutesFetcher.swift
//  brink
//
//  Created by Aria Han on 12/3/24.
//

import HealthKit
import os.log

@available(iOS 17.0, *)
class ExerciseMinutesFetcher {
    private let healthStore = HKHealthStore()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.brink", category: "ExerciseMinutesFetcher")

    func fetchExerciseMinutesData(from startDate: Date, to endDate: Date) async throws -> [ExerciseMinutesSample] {
        let exerciseMinutesType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        logger.info("Fetching exercise minutes data from \(startDate.formatted()) to \(endDate.formatted())")

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: exerciseMinutesType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]
            ) { _, samples, error in
                if let error = error {
                    self.logger.error("❌ Exercise minutes query failed: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                    return
                }
                
                let exerciseMinutesSamples = samples?.compactMap { sample -> ExerciseMinutesSample? in
                    guard let sample = sample as? HKQuantitySample else { return nil }
                    return ExerciseMinutesSample(
                        minutes: sample.quantity.doubleValue(for: HKUnit.minute()),
                        startDate: sample.startDate,
                        endDate: sample.endDate
                    )
                } ?? []
                
                self.logger.info("✅ Retrieved \(exerciseMinutesSamples.count) exercise minutes samples")
                continuation.resume(returning: exerciseMinutesSamples)
            }
            healthStore.execute(query)
        }
    }
}
