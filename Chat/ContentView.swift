//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct ContentView: View {
    @State var messages: [ChatContent] = [
        Subcontent(data: "Today"),
        BotMessage(content: "Welcome to iBot")
    ]
    @State var waitingForBot = false
    @State var isRecording = false
    @State var transcript = ""
    @State var messageText = ""

    var body: some View {
        VStack {
            HeaderView()
            ChatView(messages: $messages, waitingForBot: $waitingForBot)
            ComposerView(messageText: $messageText) {
                withAnimation {
                    isRecording = true
                }
            } sendAction: { message in
                messages.append(
                    MyMessage(content: message)
                )
                sendMessage(message)
            }

            if isRecording {
                SpeechView(
                    recording: $isRecording,
                    transcript: $transcript)
            }
        }
        .onChange(of: transcript) { newValue in
            if !newValue.isEmpty {
                messageText = newValue
            }
        }
    }

    func sendMessage(_ message: String) {
        Task {
            await sleep(seconds: 0.5)

            withAnimation {
                waitingForBot = true
            }

            let botResponse = await SendMessageWorker(message: message).execute()
            withAnimation {
                waitingForBot = false
                messages.append(
                    BotMessage(content: botResponse)
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isRecording: true)
    }
}
