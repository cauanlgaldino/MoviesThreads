//
//  ShoppingView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 27/05/25.
//

import SwiftUI
import Foundation

struct ShoppingView: View {
    @StateObject var session = MovieSessionViewModel(capacity: 3, exhibitionTime: 30)
    @State private var fanIDGenerator = 0
//    @ObservedObject var moviesVM: MovieSessionViewModel
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                
                ScreenView(size: geometry.size)
                LogsView(size: geometry.size, logs: .constant(session.log))
                DoorView(size: geometry.size)
                ProjectorView(size: geometry.size)
                SeatsView(size: geometry.size)
                HStack {
//                    Button("➕ Criar Fã") {
//                        fanIDGenerator += 1
//                        let newFan = Fan(id: moviesVM.fans[0].id, snackTime: Int(moviesVM.fans[0].snackTime), moviesVM: moviesVM)
//                        session.fans.append(newFan)
//                        newFan.start()
//                        
//                    }
//                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

struct LayoutConstants {
    static let screenWidthRatio: CGFloat = 0.55
    static let screenHeightRatio: CGFloat = 0.64
    static let logWidthRatio: CGFloat = 0.33
    static let logHeightRatio: CGFloat = 0.19
    static let doorWidthRatio: CGFloat = 0.03
    static let doorHeightRatio: CGFloat = 0.2
    static let projectorWidthRatio: CGFloat = 0.315
    static let projectorHeightRatio: CGFloat = 0.255
    static let seatWidthRatio: CGFloat = 0.09
    static let seatHeightRatio: CGFloat = 0.14
    static let theaterHeightRatio: CGFloat = 0.8
    static let theaterWidthRatio: CGFloat = 0.55
}



