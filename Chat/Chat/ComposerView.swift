//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct ComposerView: View {
    @Binding var messageText: String
    @State private var sendVisible = false
    @FocusState private var textFieldFocus: Bool
    var recordAction: () -> Void
    var sendAction: (String) -> Void

    var body: some View {
        HStack {
            HStack {
                TextField("Ask me anything", text: $messageText)
                    .foregroundColor(.primary)
                    .tint(.secondary)
                    .padding()
                    .focused($textFieldFocus)
                    .onSubmit {
                        sendMessage(messageText)
                    }
                    .onChange(of: messageText) { newValue in
                        withAnimation {
                            sendVisible = !newValue.isEmpty
                        }
                    }

                Button {
                    textFieldFocus = false
                    recordAction()
                } label: {
                    Image(systemName: "mic")
                        .font(.system(size: 26))
                        .foregroundColor(.secondary)
                        .padding(.trailing)
                }
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(30)

            if sendVisible {
                Button {
                    sendMessage(messageText)
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(Color(hex: "#41AAEF"))
                        .padding(.leading, 4)
                }
            }
        }
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
    @State static var messageText: String = ""
    static var previews: some View {
        ComposerView(messageText: $messageText) {

        } sendAction: { _ in

        }

    }
}
