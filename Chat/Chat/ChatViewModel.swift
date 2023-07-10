//
//  ChatViewModel.swift
//  Chat
//
//  Created by Ky Nguyen on 7/10/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatContent] = [
        Subcontent(data: "Today"),
        BotMessage(content: "Welcome to iBot")
    ]
    @Published var waitingForBot: Bool = false
    @Published var isRecording = false
    @Published var transcript = ""
    @Published var messageText = ""
    var services: MessageServicesList = ChatServices()

    func sendMessage(_ message: String) async -> String {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.messages.append(MyMessage(content: message))
        }

        await sleep(seconds: 0.5)

        DispatchQueue.main.async { [weak self] in
            self?.waitingForBot = true
        }

        let botResponse = await services.sendMessage(message)
        return botResponse
    }
}
