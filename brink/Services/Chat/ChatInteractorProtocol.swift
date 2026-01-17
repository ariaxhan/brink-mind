//
//  ChatInteractorProtocol.swift
//  brink
//
//  Created by Aria Han on 1/16/25.
//


//
//  Created by Alex.M on 27.06.2022.
//

import Foundation
import Combine
import ExyteChat

protocol ChatInteractorProtocol {
    var messages: AnyPublisher<[Message], Never> { get }
    var senders: [User] { get }
    var otherSenders: [User] { get }

    func send(draftMessage: ExyteChat.DraftMessage)

    func connect()
    func disconnect()

    func loadNextPage() -> Future<Bool, Never>
}
