//
//  Message.swift
//  Chat
//
//  Created by Ky Nguyen on 7/7/23.
//

import Foundation

protocol ChatContent {
    var id: String { get }
}

extension ChatContent {
    var id: String {
        UUID().uuidString
    }
}

struct Subcontent: ChatContent {
    let data: String
}

struct MyMessage: ChatContent {
    let id = UUID().uuidString
    let content: String
    let createdAt: Date

    init(content: String, createdAt: Date = Date()) {
        self.content = content
        self.createdAt = createdAt
    }
}

struct BotMessage: ChatContent {
    let id = UUID().uuidString
    let content: String
    let createdAt: Date

    init(content: String, createdAt: Date = Date()) {
        self.content = content
        self.createdAt = createdAt
    }
}
