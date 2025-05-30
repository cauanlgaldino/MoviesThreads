//
//  Snack.swift
//  MoviesThreads
//
//  Created by Júlia Saboya on 30/05/25.
//

import SwiftUI

struct Snack: View {
    var body: some View {
        HStack(spacing: -64) {
            ZStack {
                ForEach(0 ..< 15) { item in
                    Rectangle()
                        .foregroundStyle(.migalha)
                        .frame(width: 4, height: 4)
                        .modifier(MigalhasAnimation())
                }

                Image(.burgue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding().padding()
                    .frame(width: 200)
                    .modifier(BurguerAnimation())

            }
            Image(.batataFrita)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70)

                .modifier(PotatosAnimation())
                .zIndex(-1)


        }
    }
}
#Preview {
    Snack()
}
