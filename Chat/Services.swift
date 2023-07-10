//
//  Services.swift
//  Chat
//
//  Created by Ky Nguyen on 7/11/23.
//

import Foundation

protocol MessageServicesList {
    func sendMessage(_ message: String) async -> String
}

struct ChatServices: MessageServicesList {
    func sendMessage(_ message: String) async -> String {
        let botResponse = await SendMessageWorker(message: message).execute()
        return botResponse
    }
}
