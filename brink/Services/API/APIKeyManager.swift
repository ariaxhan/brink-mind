//
//  APIKeyManager.swift
//  brink
//
//  Created by Aria Han on 12/4/24.
//

import Foundation
import SwiftKeychainWrapper

struct APIKeyManager {
    
    let apiKey = "API_KEY"
    
    /// Saves the API key to the Keychain.
    /// - Parameter key: The API key string to save.
    /// - Returns: A boolean indicating success or failure.
    func saveApiKey(_ key: String) -> Bool {
        let success = KeychainWrapper.standard.set(key, forKey: apiKey, withAccessibility: .whenUnlocked)
        if success {
            print("Successfully saved API key to Keychain.")
        } else {
            print("Failed to save API key to Keychain.")
        }
        return success
    }
    
    /// Loads the API key from the Keychain.
    /// - Returns: The API key string if it exists, otherwise `nil`.
    func loadApiKey() -> String? {
        if let key = KeychainWrapper.standard.string(forKey: apiKey) {
            print("Successfully loaded API key from Keychain: \(key)")
            return key
        } else {
            print("API key not found in Keychain.")
            return nil
        }
    }
    
    /// Deletes the API key from the Keychain.
    /// - Returns: A boolean indicating success or failure.
    func deleteApiKey() -> Bool {
        let success = KeychainWrapper.standard.removeObject(forKey: apiKey)
        if success {
            print("Successfully deleted API key from Keychain.")
        } else {
            print("Failed to delete API key from Keychain.")
        }
        return success
    }
}
