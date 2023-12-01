//
//  Cardify.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 23/11/23.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    private var rotation: Double
    private var flipped: Bool { rotation > 90 }
    
    init(flipped: Bool) {
        rotation = flipped ? 180 : 0
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    private let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
    
    func body(content: Content) -> some View {
        ZStack {
            shape
                .strokeBorder(lineWidth: Constants.lineWidth)
                .background(shape.fill(.cardForeground))
                .overlay(content)
                .opacity(flipped ? 0 : 1)
            
            shape
                .fill()
                .opacity(flipped ? 1 : 0)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(flipped: Bool) -> some View {
        modifier(Cardify(flipped: flipped))
    }
}
