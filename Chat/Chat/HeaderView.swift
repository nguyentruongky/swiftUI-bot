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
            AsyncImage(
                url: URL(string: "https://mg.co.za/wp-content/uploads/2023/03/stevejobs.1419962519.jpeg"),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 40, maxHeight: 40)
                        .cornerRadius(20)
                        .overlay(
                            Circle()
                                .stroke(
                                    Color(hex: "#B7B6BB")!
                                        .opacity(0.15),
                                    lineWidth: 0.5)
                        )
                },
                placeholder: {
                    ProgressView()
                        .padding()
                }
            )

            VStack(alignment: .leading) {
                Text("Good morning, Samantha")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(Color(hex: "#1C1C1E"))
                Text("How can I help you today?")
                    .foregroundColor(Color(hex: "#868A99"))
            }

            Spacer()
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
