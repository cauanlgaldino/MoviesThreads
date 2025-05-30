//
//  Snack.swift
//  MoviesThreads
//
//  Created by Júlia Saboya on 30/05/25.
//

import SwiftUI

struct Snack: View {
    var proxy: GeometryProxy
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(.batataFrita)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: proxy.size.width/8)
                    .offset(x: proxy.size.width/9, y: -proxy.size.height/16)
                    .modifier(PotatosAnimation())
                
                ForEach(0 ..< 15) { item in
                    Rectangle()
                        .foregroundStyle(.migalha)
                        .frame(width: proxy.size.width/100, height: proxy.size.height/100)
                        .modifier(MigalhasAnimation())
                }
                
                Image(.burgue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: proxy.size.width/5)
                    .modifier(BurguerAnimation())
            }
        }
    }
}

#Preview {
    GeometryReader { proxy in
        Snack(proxy: proxy)
    }
}
