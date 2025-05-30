//
//  BurguerAnimation.swift
//  MoviesThreads
//
//  Created by Júlia Saboya on 30/05/25.
//
import SwiftUI

struct BurguerAnimation: ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyframeAnimator(initialValue: Keyframes(), repeating: true) { view, frame in
                view
                    .rotationEffect(.degrees(frame.angle))
                    .scaleEffect(frame.scale)

            } keyframes: { _ in
                KeyframeTrack(\.angle) {
                    LinearKeyframe(-10, duration: 0.05)
                    LinearKeyframe(15, duration: 0.05)

                }
                KeyframeTrack(\.scale) {
                    LinearKeyframe(1.2, duration: 0.1)
                    LinearKeyframe(1, duration: 0.05)
                }
            }

    }
}

struct PotatosAnimation: ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyframeAnimator(initialValue: Keyframes(), repeating: true) { view, frame in
                view
                    .scaleEffect(frame.scale)

            } keyframes: { _ in

                KeyframeTrack(\.scale) {
                    LinearKeyframe(1.2, duration: 0.5)
                    LinearKeyframe(1, duration: 0.2)
                }
            }

    }
}

struct MigalhasAnimation: ViewModifier {

    func body(content: Content) -> some View {
        let randomOffsetX1 = CGFloat.random(in: -150...150)
        let randomOffsetX2 = CGFloat.random(in: -80 ... -50)
        let migalheSize = CGFloat.random(in: 0.5...1.5)
        let migalhaOpacity = Double.random(in: 0.7...1)

        content
            .keyframeAnimator(initialValue: Keyframes(), repeating: true) { view, frame in
                view
                    .scaleEffect(migalheSize)
                    .offset(x: frame.offsetX, y: frame.offsetY)
                    .opacity(migalhaOpacity)

            } keyframes: { _ in

                KeyframeTrack(\.offsetX) {
                    CubicKeyframe(randomOffsetX1, duration: 0.2)
                    CubicKeyframe(randomOffsetX1, duration: 0.2)
                    CubicKeyframe(0, duration: 0.2)

                }
                KeyframeTrack(\.offsetY) {
                    CubicKeyframe(randomOffsetX2, duration: 0.2)
                    CubicKeyframe(-randomOffsetX2/3, duration: 0.2)
                    CubicKeyframe(10, duration: 0.2)

                }


            }


    }
}


