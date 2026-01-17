//
//  HealthPermissionsManager.swift
//  brink
//
//  Created by Aria Han on 12/4/24.
//

import Foundation
import HealthKit

class HealthPermissionsManager {
    static let shared = HealthPermissionsManager()
    
    private let healthStore = HKHealthStore()
    
    init() {}

    // Request HealthKit authorization
    func requestHealthKitAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthKitError.healthKitNotAvailable)
            return
        }
        
        let readTypes: Set<HKObjectType> = [
            HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!, // Sleep Analysis
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!, // Exercise Minutes
            HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)! // HRV
        ]

        healthStore.requestAuthorization(toShare: [], read: readTypes) { success, error in
            completion(success, error ?? HealthKitError.authorizationDenied)
        }
    }
}

enum HealthKitError: LocalizedError {
    case healthKitNotAvailable
    case authorizationDenied
    
    var errorDescription: String? {
        switch self {
        case .healthKitNotAvailable:
            return "HealthKit is not available on this device"
        case .authorizationDenied:
            return "HealthKit authorization was denied"
        }
    }
}
