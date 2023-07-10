//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var chatViewModel = ChatViewModel()
    @ObservedObject var speechViewModel = SpeechViewModel()

    var body: some View {
        VStack {
            HeaderView()

            ChatView(viewModel: chatViewModel)

            ComposerView(
                messageText: $chatViewModel.messageText,
                recordAction: showRecord,
                sendAction: send
            )

            if chatViewModel.isRecording {
                SpeechView(viewModel: speechViewModel)
            }
        }
        .onReceive(speechViewModel.$recordStatus, perform: { value in
            chatViewModel.isRecording = value != .idle
        })
        .onChange(of: speechViewModel.transcript) { newValue in
            if !newValue.isEmpty {
                chatViewModel.messageText = newValue
            }
        }
    }

    private func showRecord() {
        withAnimation {
            chatViewModel.isRecording = true
        }
    }

    private func send(message: String) {
        Task {
            let botResponse = await chatViewModel.sendMessage(message)
            withAnimation {
                chatViewModel.waitingForBot = false
                chatViewModel.messages.append(
                    BotMessage(content: botResponse)
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
