//
//  HRVFetcher.swift
//  brink
//
//  Created by Aria Han on 12/3/24.
//

import HealthKit
import os.log

@available(iOS 17.0, *)
class HRVFetcher {
    private let healthStore = HKHealthStore()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.brink", category: "HRVFetcher")

    func fetchHRVData(from startDate: Date, to endDate: Date) async throws -> [HRVSample] {
        let hrvType = HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        logger.info("Fetching HRV data from \(startDate.formatted()) to \(endDate.formatted())")

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: hrvType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]
            ) { _, samples, error in
                if let error = error {
                    self.logger.error("❌ HRV query failed: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                    return
                }
                
                let hrvSamples = samples?.compactMap { sample -> HRVSample? in
                    guard let sample = sample as? HKQuantitySample else { return nil }
                    return HRVSample(
                        value: sample.quantity.doubleValue(for: HKUnit(from: "ms")),
                        startDate: sample.startDate,
                        endDate: sample.endDate
                    )
                } ?? []
                
                self.logger.info("✅ Retrieved \(hrvSamples.count) HRV samples")
                continuation.resume(returning: hrvSamples)
            }
            healthStore.execute(query)
        }
    }
}
