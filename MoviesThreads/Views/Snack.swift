////
////  Snack.swift
////  MoviesThreads
////
////  Created by Júlia Saboya on 30/05/25.
////
//
//import SwiftUI
//
//struct Snack: View {
//    var proxy: GeometryProxy
//    var body: some View {
//        GeometryReader { proxy in
//            ZStack {
//                Image(.batataFrita)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: proxy.size.width/8)
//                    .offset(x: proxy.size.width/9, y: -proxy.size.height/16)
//                    .modifier(PotatosAnimation())
//                
//                ForEach(0 ..< 15) { item in
//                    Rectangle()
//                        .foregroundStyle(.migalha)
//                        .frame(width: proxy.size.width/100, height: proxy.size.height/100)
//                        .modifier(MigalhasAnimation())
//                }
//                
//                Image(.burgue)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: proxy.size.width/5)
//                    .modifier(BurguerAnimation())
//            }
//        }
//    }
//}
//
//#Preview {
//    GeometryReader { proxy in
//        Snack(proxy: proxy)
//    }


import SwiftUI

struct Snack: View {
    var proxy: GeometryProxy // Mantenha este proxy para dimensionamento interno
    var index: Int // NOVO: Propriedade para o índice da Snack View
    var onPositionUpdate: (Int, CGPoint) -> Void // NOVO: Closure para reportar a posição

    var body: some View {
        GeometryReader { geo in // Renomeei o proxy interno para 'geo' para evitar conflito com o 'proxy' da struct
            ZStack {
                Image(.batataFrita)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width/8) // Use 'geo' aqui
                    .offset(x: geo.size.width/9, y: -geo.size.height/16) // Use 'geo' aqui
                    .modifier(PotatosAnimation())

                ForEach(0 ..< 15) { item in
                    Rectangle()
                        .foregroundStyle(.migalha)
                        .frame(width: geo.size.width/100, height: geo.size.height/100) // Use 'geo' aqui
                        .modifier(MigalhasAnimation())
                }

                Image(.burgue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width/5) // Use 'geo' aqui
                    .modifier(BurguerAnimation())
            }
            .onAppear { // NOVO: Quando a view aparece, reporte sua posição
                let midX = geo.frame(in: .global).midX
                let midY = geo.frame(in: .global).midY
                onPositionUpdate(index, CGPoint(x: midX, y: midY)) // Chame o closure com o índice e a posição
            }
        }
    }
}

#Preview {
    GeometryReader { proxy in
        // No Preview, precisamos passar um valor dummy para index e onPositionUpdate
        Snack(proxy: proxy, index: 0) { reportedIndex, position in
            print("Snack Preview Position: \(position) at index \(reportedIndex)")
        }
    }
}
