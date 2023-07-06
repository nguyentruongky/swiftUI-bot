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
                .foregroundColor(isMyChat ? .white : .black)
                .background(
                    isMyChat ?
                        Color.blue.opacity(0.8) :
                        Color.gray.opacity(0.1)
                )
                .cornerRadius(16)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)

            if !isMyChat {
                Spacer()
            }
        }
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(message: "Hello", isMyChat: false)
    }
}
