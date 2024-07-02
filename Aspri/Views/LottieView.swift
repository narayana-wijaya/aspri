//
//  LottieView.swift
//  Aspri
//
//  Created by Narayana Wijaya on 02/07/24.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let name: LottieFiles
    let loopMode: LottieLoopMode
    let contentMode: UIView.ContentMode
    
    let animationView: LottieAnimationView
    
    init(name: LottieFiles, loopMode: LottieLoopMode = .loop, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.name = name
        self.loopMode = loopMode
        self.animationView = LottieAnimationView(name: name.rawValue)
        self.contentMode = contentMode
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.play()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
