//
//  ResponseParser.swift
//  brink
//
//  Created by Aria Han on 12/3/24.
//

import Foundation

// Define Codable structs to represent the response structure

struct ChatCompletionResponse: Codable {
    let response: ChatResponse
}

struct ChatResponse: Codable {
    let choices: [ChatChoice]
}

struct ChatChoice: Codable {
    let message: ChatMessage
}

struct ChatMessage: Codable {
    let role: String
    let content: String
}


// Function to parse the chat completion response

public func parseChatCompletion(data: Data) throws -> String {
    print("Parsing chat completion response")

    // Decode the data as a UTF-8 string
    if var responseString = String(data: data, encoding: .utf8) {
        print("Original content: \(responseString)")

        // Remove all quotes from the response string
        responseString = responseString.replacingOccurrences(of: "\"", with: "")
        
        print("Parsed content without quotes: \(responseString)")
        return responseString
    } else {
        print("Failed to decode response as UTF-8 string")
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode assistant response as plain text"])
    }
}
