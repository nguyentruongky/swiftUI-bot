//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.messages, id: \.id) { message in

                    chatContent(message: message)

                }
                .rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))

            if viewModel.waitingForBot {
                HStack {
                    LottieView()
                        .frame(width: 150, height: 150)
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
        }
    }

    @ViewBuilder
    func chatContent(message: ChatContent) -> some View {
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
    }
}

struct ChatView_Previews: PreviewProvider {
    static let viewModel = ChatViewModel()
    static var previews: some View {
        ChatView(viewModel: viewModel)
    }
}
