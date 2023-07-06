//
//  ChatApp.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("iBot")
                .font(.largeTitle)
                .bold()

            Image(systemName: "bubble.left.fill")
                .font(.system(size: 26))
                .foregroundColor(.blue)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
