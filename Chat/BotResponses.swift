//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import Foundation

func getBotResponses(message: String) -> String {
    let inputContent = message.lowercased()

    switch inputContent {
    case "hello":
        return "Hey there!"
    case "bye":
        return "Talk to you later!"
    case "how are you?":
        return "Good, how are you?"
    default:
        return "Sounds good!"
    }
}
