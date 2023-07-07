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
            TextField("Type something", text: $messageText)
                .padding()
                .focused($textFieldFocus)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .onSubmit {
                    sendMessage(messageText)
                }

            Button {
                sendMessage(messageText)
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 26))
                    .padding(.horizontal, 10)
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 10)
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
        ComposerView(sendAction: { _ in })
    }
}
