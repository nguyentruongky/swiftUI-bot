//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct ComposerView: View {
    @State private var messageText = ""
    @FocusState private var textFieldFocus: Bool
    var sendAction: (String) -> Void

    var body: some View {
        HStack {
            TextField("Ask me anything", text: $messageText)
                .foregroundColor(.primary)
                .tint(.secondary)
                .padding()
                .focused($textFieldFocus)
                .onSubmit {
                    sendMessage(messageText)
                }

            Button {
                sendMessage(messageText)
            } label: {
                Image(systemName: "mic")
                    .font(.system(size: 26))
                    .foregroundColor(.secondary)
                    .padding(.trailing)
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(30)
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }

    func sendMessage(_ message: String) {
        let newMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
        withAnimation {
            sendAction(newMessage)
            messageText = ""
        }

        textFieldFocus = true
    }
}

struct ComposerView_Previews: PreviewProvider {
    static var previews: some View {
        ComposerView(sendAction: { _ in }).preferredColorScheme(.dark)
        ComposerView(sendAction: { _ in }).preferredColorScheme(.light)
    }
}
