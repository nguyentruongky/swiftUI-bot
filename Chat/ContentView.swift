//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct ContentView: View {
    @State var messages: [String] = ["Welcome to iBot", "[USER]: Hey", "Yo"]

    var body: some View {
        VStack {
            HeaderView()
            ChatView(messages: $messages)
            ComposerView { message in
                messages.append(message)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
