//
//  EmitterView.swift
//  FieldValidators
//
//  Created by John Bethancourt on 1/5/21.
//

import SwiftUI
import UIKit
import SpriteKit

struct Surprise: View {
    
    var body: some View {
        VStack{
            Spacer()
            EmitterView()
                .background(Color.clear)
        }
        .zIndex(-1)
    }
}

struct EmitterView: UIViewRepresentable {
    /**
     makeUIView and updateUIView are required methods of the UIViewRepresentable
     protocol. makeUIView does just what you'd think - makes the view we want.
     
     updateUIView allows you to update the view with new data, but we don't need
     it for our purposes.
     */
    func makeUIView(context: UIViewRepresentableContext<EmitterView>) -> SKView {
        // Create our SKView
        let view = SKView()
        // We want the view to animate the particle effect over our SwiftUI view
        // and let its components show through so we'll set allowsTransparenty to true.
        view.allowsTransparency = true
        // Load our custom SKScene
        if let scene = FireScene(fileNamed: "MyScene") {
            // We need to set the background to clear.
            scene.backgroundColor =  .clear
            view.presentScene(scene)
        }
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: UIViewRepresentableContext<EmitterView>) {
        
    }
    
}

/**
 This is our SKScene subclass that will present the emitter node.
 */
class FireScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        if let emitter: SKEmitterNode = SKEmitterNode(fileNamed: "MyParticle") {
            
            emitter.alpha = 0
            addChild(emitter)
            emitter.run(SKAction.fadeIn(withDuration: 0.3)) {
                emitter.run(SKAction.fadeOut(withDuration: 5.0)) {
                    emitter.removeFromParent()
                    
                }
            }
        }
    }
    
}
