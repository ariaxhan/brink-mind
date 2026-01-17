//
//  HeartRateFetcher.swift
//  brink
//
//  Created by Aria Han on 12/3/24.
//

import HealthKit
import os.log

@available(iOS 17.0, *)
class HeartRateFetcher {
    private let healthStore = HKHealthStore()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.brink", category: "HeartRateFetcher")

    func fetchHeartRateData(from startDate: Date, to endDate: Date) async throws -> [HeartRateSample] {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        logger.info("Fetching heart rate data from \(startDate.formatted()) to \(endDate.formatted())")
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: heartRateType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]
            ) { _, samples, error in
                if let error = error {
                    self.logger.error("❌ Heart rate query failed: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                    return
                }
                
                let heartRateSamples = samples?.compactMap { sample -> HeartRateSample? in
                    guard let quantitySample = sample as? HKQuantitySample else { return nil }
                    return HeartRateSample(
                        value: quantitySample.quantity.doubleValue(for: HKUnit(from: "count/min")),
                        startDate: quantitySample.startDate,
                        endDate: quantitySample.endDate
                    )
                } ?? []
                
                self.logger.info("✅ Retrieved \(heartRateSamples.count) heart rate samples")
                continuation.resume(returning: heartRateSamples)
            }
            healthStore.execute(query)
        }
    }
}
