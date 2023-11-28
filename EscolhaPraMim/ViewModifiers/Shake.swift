//
//  Shake.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 27/11/23.
//

import SwiftUI

fileprivate struct Shake {
    struct Animation {
        static func wiggle(interval: TimeInterval, variance: Double) -> SwiftUI.Animation {
            SwiftUI.Animation
                .easeInOut(duration: randomize(interval: interval, withVariance: variance))
                .repeatForever(autoreverses: true)
        }
        
        static func randomize(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
            let random = Double.random(in: -1.0...1.0)
            return interval + variance * random
        }
        
        static var bounce: SwiftUI.Animation {
            wiggle(interval: 0.3, variance: 0.025)
        }
        
        static var rotate: SwiftUI.Animation {
            wiggle(interval: 0.12, variance: 0.025)
        }
    }
    
    struct BounceEffect: GeometryEffect {
        private var amount: CGFloat
        private var bounceAmount: CGFloat
        
        init(_ bouncing: Bool, bounceAmount: CGFloat) {
            self.amount = bouncing ? 1 : 0
            self.bounceAmount = bounceAmount
        }
        
        var animatableData: CGFloat {
            get { amount }
            set { amount = newValue }
        }
        
        func effectValue(size: CGSize) -> ProjectionTransform {
            let bounce = sin(.pi * 2 * amount) * bounceAmount
            let translationEffect = CGAffineTransform(translationX: 0, y: bounce)
            return ProjectionTransform(translationEffect)
        }
    }
    
    struct RotationEffect: GeometryEffect {
        private var amount: CGFloat
        private var rotationAmount: CGFloat
        
        init(_ rotating: Bool, rotationAmount: CGFloat) {
            self.amount = rotating ? 1 : 0
            self.rotationAmount = rotationAmount
        }
        
        var animatableData: CGFloat {
            get { amount }
            set { amount = newValue }
        }
        
        func effectValue(size: CGSize) -> ProjectionTransform {
            let angle = Angle(degrees: amount * rotationAmount)
            var transform = CGAffineTransform(translationX: size.width/2.0, y: size.height/2)
            transform = CGAffineTransformRotate(transform, angle.radians)
            transform = CGAffineTransformTranslate(transform, -size.width/2.0, -size.height/2)
            return ProjectionTransform(transform)
        }
    }
    
}


extension View {
    func shake(isShaking: Bool, bounceAmount: CGFloat = 1, rotationAmount: CGFloat = 3) -> some View {
        let rotationAnimation = isShaking ? Shake.Animation.rotate : .default
        let bounceAnimation = isShaking ? Shake.Animation.bounce : .default
        return self
            .modifier(Shake.RotationEffect(isShaking, rotationAmount: rotationAmount))
            .animation(rotationAnimation, value: isShaking)
            .modifier(Shake.BounceEffect(isShaking, bounceAmount: bounceAmount))
            .animation(bounceAnimation, value: isShaking)
    }
}
