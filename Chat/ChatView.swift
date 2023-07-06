//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct ChatView: View {
    @Binding var messages: [String]

    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(messages, id: \.self) { message in
                if message.starts(with: "[USER]") {
                    let newMessage = message.replacingOccurrences(of: "[USER]: ", with: "")
                    BubbleView(message: newMessage, isMyChat: true)
                } else {
                    BubbleView(message: message, isMyChat: false)
                }
            }.rotationEffect(.degrees(180))
        }.rotationEffect(.degrees(180))
    }
}

struct ChatView_Previews: PreviewProvider {
    @State static var messages: [String] = ["Welcome to iBot", "[USER]: Hey", "Yo"]

    static var previews: some View {
        ChatView(messages: $messages)
    }
}
