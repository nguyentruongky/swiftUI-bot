//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct ChatView: View {
    @Binding var messages: [ChatContent]
    @Binding var waitingForBot: Bool

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(messages, id: \.id) { message in
                    switch message {
                    case let subcontent as Subcontent:
                        Text(subcontent.data)
                            .foregroundColor(.gray)

                    case let myMessage as MyMessage:
                        BubbleView(message: myMessage.content, isMyChat: true)

                    case let botMessage as BotMessage:
                        BubbleView(message: botMessage.content, isMyChat: false)

                    default:
                        Text("")
                    }

                }.rotationEffect(.degrees(180))
            }.rotationEffect(.degrees(180))

            if waitingForBot {
                HStack {
                    LottieView()
                        .frame(width: 150, height: 150)
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    @State static var messages: [ChatContent] = [
        Subcontent(data: "Today"),
        MyMessage(content: "Hello"),
        BotMessage(content: "How are you?")
    ]
    @State static var waitingForBot = true

    static var previews: some View {
        ChatView(messages: $messages, waitingForBot: $waitingForBot)
    }
}
