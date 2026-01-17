//
//  StepCountFetcher.swift
//  brink
//
//  Created by Aria Han on 12/3/24.
//

import HealthKit
import os.log

@available(iOS 17.0, *)
class StepCountFetcher {
    private let healthStore = HKHealthStore()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.brink", category: "StepCountFetcher")

    func fetchStepCountData(from startDate: Date, to endDate: Date) async throws -> [StepCountSample] {
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        logger.info("Fetching step count data from \(startDate.formatted()) to \(endDate.formatted())")

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: stepCountType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]
            ) { _, samples, error in
                if let error = error {
                    self.logger.error("❌ Step count query failed: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                    return
                }
                
                let stepCountSamples = samples?.compactMap { sample -> StepCountSample? in
                    guard let sample = sample as? HKQuantitySample else { return nil }
                    return StepCountSample(
                        steps: sample.quantity.doubleValue(for: HKUnit.count()),
                        startDate: sample.startDate,
                        endDate: sample.endDate
                    )
                } ?? []
                
                self.logger.info("✅ Retrieved \(stepCountSamples.count) step count samples")
                continuation.resume(returning: stepCountSamples)
            }
            healthStore.execute(query)
        }
    }
}
