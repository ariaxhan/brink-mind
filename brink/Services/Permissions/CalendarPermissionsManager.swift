//
//  CalendarPermissionsManager.swift
//  brink
//
//  Created by Aria Han on 12/4/24.
//

import Foundation
import EventKit

class CalendarPermissionsManager {
    static let shared = CalendarPermissionsManager()
    
    private let eventStore = EKEventStore()
    
    private init() {}

    // Request full access to calendar events
    func requestCalendarAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        eventStore.requestFullAccessToEvents { granted, error in
            completion(granted, error)
        }
    }
}
