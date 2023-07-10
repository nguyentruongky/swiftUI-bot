//
//  SendMessageWorker.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import Foundation

struct SendMessageWorker {
    let message: String
    func execute() async -> String {
        // Connect API...

        await sleep(seconds: 2)
        return getBotResponses(message: message)
    }
}
