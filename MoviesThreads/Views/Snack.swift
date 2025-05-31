//
//  Snack.swift
//  MoviesThreads
//
//  Created by Júlia Saboya on 30/05/25.
//

import SwiftUI

struct Snack: View {
    var proxy: GeometryProxy
    var index: Int
    var onPositionUpdate: (Int, CGPoint) -> Void

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.batataFrita)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width/8)
                    .offset(x: geo.size.width/9, y: -geo.size.height/16)
                    .modifier(PotatosAnimation())

                ForEach(0 ..< 15) { item in
                    Rectangle()
                        .foregroundStyle(.migalha)
                        .frame(width: geo.size.width/100, height: geo.size.height/100)
                        .modifier(MigalhasAnimation())
                }

                Image(.burgue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width/5)
                    .modifier(BurguerAnimation())
            }
            .onAppear {
                let midX = geo.frame(in: .global).midX
                let midY = geo.frame(in: .global).midY
                onPositionUpdate(index, CGPoint(x: midX, y: midY))
            }
        }
    }
}

#Preview {
    GeometryReader { proxy in
        Snack(proxy: proxy, index: 0) { reportedIndex, position in
            print("Snack Preview Position: \(position) at index \(reportedIndex)")
        }
    }
}
