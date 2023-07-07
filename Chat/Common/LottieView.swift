//
//  BotProcessingView.swift
//  Chat
//
//  Created by Ky Nguyen on 7/6/23.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    var name = "chatbotAnimation"
    var loopMode: LottieLoopMode = .loop

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView(name: name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}


struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView()
    }
}
