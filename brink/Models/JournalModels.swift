//
//  JournalModels.swift
//  brink
//
//  Created by Aria Han on 12/5/24.
//

import Foundation
import CoreData

enum TagCategory: String, CaseIterable {
    case mood = "Mood"
    case sleep = "Sleep"
    case activity = "Activity"
    case health = "Health"
    case custom = "Custom"
    
    var systemImage: String {
        switch self {
        case .mood: return "face.smiling"
        case .sleep: return "bed.double"
        case .activity: return "figure.walk"
        case .health: return "heart"
        case .custom: return "tag"
        }
    }
}


// MARK: - HealthMetric Storage
struct HealthMetricValue: Codable {
    let value: Double
    let unit: String
    let timestamp: Date
}

// MARK: - Managed Object Extensions
extension JournalEntryMO {
    var wrappedHealthMetrics: [String: HealthMetricValue] {
        get {
            guard let data = healthData else { return [:] }
            return (try? JSONDecoder().decode([String: HealthMetricValue].self, from: data)) ?? [:]
        }
        set {
            healthData = try? JSONEncoder().encode(newValue)
        }
    }
    
    var tagArray: [TagMO] {
        (tags as? Set<TagMO> ?? []).sorted { $0.name ?? "" < $1.name ?? "" }
    }
    
    func toModel() -> JournalEntry? {
        guard let id = id,
              let date = date,
              let content = content,
              let title = title, // Ensure title exists
              let prompt = prompt // Ensure prompt exists
        else {
            return nil
        }
        
        return JournalEntry(
            id: id,
            date: date,
            title: title,
            prompt: prompt,
            content: content,
            tags: Set(tagArray.compactMap { $0.name }),
            healthMetrics: wrappedHealthMetrics.reduce(into: [:]) { result, pair in
                if let metric = HealthMetric(rawValue: pair.key) {
                    result[metric] = pair.value
                }
            }
        )
    }
}

extension TagMO {
    var entryArray: [JournalEntryMO] {
        (entries as? Set<JournalEntryMO> ?? []).sorted { $0.date ?? Date.distantPast < $1.date ?? Date.distantPast }
    }
    
    func toModel() -> Tag? {
        guard let name = name,
              let category = category,
              let lastUsed = lastUsed else {
            return nil
        }
        
        return Tag(
            name: name,
            category: TagCategory(rawValue: category) ?? .custom,
            lastUsed: lastUsed,
            useCount: Int(useCount)
        )
    }
}

// MARK: - Model Types
struct Tag: Identifiable, Hashable {
    var id: String { name }
    let name: String
    let category: TagCategory
    let lastUsed: Date
    let useCount: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        lhs.name == rhs.name
    }
}

struct JournalEntry: Identifiable, Hashable {
    let id: UUID
    let date: Date
    let title: String
    let prompt: String
    let content: String
    let tags: Set<String>
    var healthMetrics: [HealthMetric: HealthMetricValue]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: JournalEntry, rhs: JournalEntry) -> Bool {
        lhs.id == rhs.id
    }
}



struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        // Add preview data if needed
        return controller
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Journal") // Update with your model name
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
