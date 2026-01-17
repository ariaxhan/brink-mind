//
//  ChatModels.swift
//  brink
//
//  Created by Aria Han on 1/14/25.
//

import SwiftUI

//
//struct Message: Identifiable, Equatable, Codable {
//    let id = UUID()
//    let text: String
//    let isUser: Bool
//    let timestamp = Date()
//    
//    static func == (lhs: Message, rhs: Message) -> Bool {
//        lhs.id == rhs.id
//    }
//}

// Constants
public enum MessageConstants {
    static let spacing: CGFloat = 12
    static let bubbleSpacing: CGFloat = 12
    static let minSideSpacing: CGFloat = 60
    static let bubblePadding = EdgeInsets(
        top: 8,
        leading: 12,
        bottom: 8,
        trailing: 12
    )
    static let maxWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    
    enum Typography {
        static let messageText: CGFloat = 16
        static let timestamp: CGFloat = 12
    }
    
    enum Bubble {
        static let cornerRadius: CGFloat = 16
        static let tailWidth: CGFloat = 10
        static let tailHeight: CGFloat = 10
        static let shadowRadius: CGFloat = 2
    }
}


struct AnimationConfig {
    static let baseSpeed: Double = 0.1
    static let noiseScale: Double = 0.15
    static let baseSize: CGFloat = 275
    static let pointCount: Int = 200
    static let radiusMultiplier: CGFloat = 0.4
}

import Foundation

enum ChatError: Error {
    case unknown(source: Error?)
}
//
//  Created by Alex.M on 28.06.2022.
//

import Foundation
import ExyteChat

struct MockImage {
    let id: String
    let thumbnail: URL
    let full: URL

    func toChatAttachment() -> Attachment {
        Attachment(
            id: id,
            thumbnail: thumbnail,
            full: full,
            type: .image
        )
    }
}

struct MockVideo {
    let id: String
    let thumbnail: URL
    let full: URL

    func toChatAttachment() -> Attachment {
        Attachment(
            id: id,
            thumbnail: thumbnail,
            full: full,
            type: .video
        )
    }
}
