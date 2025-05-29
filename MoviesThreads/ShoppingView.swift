//
//  ShoppingView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 27/05/25.
//

import SwiftUI
import Foundation

struct ShoppingView: View {
    @StateObject var moviesVM = MovieSessionViewModel(capacity: 3, exhibitionTime: 30)
    @State private var fanIDGenerator = 0
    @State private var showingCreateFanSheet = false
//    @ObservedObject var moviesVM: MovieSessionViewModel
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                
                if !moviesVM.fans.isEmpty {
                    ForEach(moviesVM.fans) { fan in
                        VStack {
                            FanView(fan: fan, size: geometry.size)
                        }
                    }
                }
                
                ScreenView(size: geometry.size)
                LogsView(size: geometry.size, logs: .constant(moviesVM.log))
                DoorView(size: geometry.size)
                ProjectorView(size: geometry.size)
                SeatsView(size: geometry.size)
                HStack {
                    Button("➕ Criar Fã") {
                    showingCreateFanSheet = true
                }
                .buttonStyle(.borderedProminent)
                }
            }
            .sheet(isPresented: $showingCreateFanSheet) {
                            CreateFanWindowView(
                                // 4. Passamos o Binding para availableFanNames do moviesVM
                                moviesVM: moviesVM, onAddFan: { fanID, snackTimeInt in
                                    let newFan = Fan(id: fanID, snackTime: snackTimeInt, moviesVM: moviesVM)
                                    moviesVM.fans.append(newFan)
                                    newFan.start()
                                    // 5. Chamamos o método do ViewModel para marcar o nome como usado
                                    moviesVM.markFanNameAsUsed(fanID)
                                }
                            )
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



