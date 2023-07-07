//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct BubbleView: View {
    var message: String
    var isMyChat: Bool
    var body: some View {
        HStack {
            if isMyChat {
                Spacer()
            }

            Text(message)
                .padding()
                .foregroundColor(isMyChat ? .white : Color("BotBubbleForeground"))
                .background(
                    isMyChat ?
                        Color("MyBubbleBackground") :
                        Color("BotBubbleBackground")
                )
                .cornerRadius(16, corners: [.topLeft, .topRight, isMyChat ?  .bottomLeft : .bottomRight])
                .padding(.horizontal)
                .padding(.bottom)

            if !isMyChat {
                Spacer()
            }
        }
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                BubbleView(message: "How can I best prepare for a job interview in my desired career field?", isMyChat: false)
                BubbleView(message: "Hello", isMyChat: true)
            }.preferredColorScheme(.light)

            VStack {
                BubbleView(message: "How can I best prepare for a job interview in my desired career field?", isMyChat: false)
                BubbleView(message: "Hello", isMyChat: true)
            }.preferredColorScheme(.dark)
        }
    }
}
