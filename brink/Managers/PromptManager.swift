//
//  PromptManager.swift
//  brink
//
//  Created by Aria Han on 1/9/25.
//


import Foundation

class PromptManager {
    private let prompts: [String]

    init() {
        prompts = PromptManager.loadPromptsFromCSV() ?? [
            "Reflect on your accomplishments today.",
            "What made you smile today?",
            "What's something you learned recently?",
            "What's a challenge you're facing?",
            "What are you grateful for today?",
            "What's something you're looking forward to?",
            "How are you taking care of yourself today?",
            "What's been on your mind lately?"
        ]
    }

    private static func loadPromptsFromCSV() -> [String]? {
        guard let filePath = Bundle.main.path(forResource: "prompts", ofType: "csv") else {
            print("Error: prompts.csv file not found.")
            return nil
        }

        do {
            let content = try String(contentsOfFile: filePath, encoding: .utf8)
            let lines = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
            return lines
        } catch {
            print("Error reading prompts.csv: \(error.localizedDescription)")
            return nil
        }
    }

    func getPrompts() -> [String] {
        return prompts
    }
}

