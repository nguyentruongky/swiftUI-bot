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
    var foreground: Color {
        isMyChat ? .white : Color("BotBubbleForeground")
    }

    var background: Color {
        isMyChat ?
            Color("MyBubbleBackground") :
            Color("BotBubbleBackground")
    }

    var body: some View {
        HStack {
            if isMyChat {
                Spacer()
            }

            Text(message)
                .padding()
                .foregroundColor(foreground)
                .background(background)
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
