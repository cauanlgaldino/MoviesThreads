//
//  ShoppingView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 27/05/25.
//

import SwiftUI
import Foundation

struct ShoppingView: View {
    let initialCapacity: Int
    let initialExhibitionTime: Int
    
    @ObservedObject var moviesVM: MovieSessionViewModel
    
    @State private var showingCreateFanSheet = false
    
    
    init(capacity: Int, exibitionTime: Int) {
        self.initialCapacity = capacity
        self.initialExhibitionTime = exibitionTime
        self.moviesVM = MovieSessionViewModel(capacity: capacity, exhibitionTime: exibitionTime)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)


                VStack(spacing: 0) {
                    Image(.pele)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/3)
                        .padding()

                    HStack {
                        ForEach(0..<5) { _ in
                            Image(.chairBrown)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/12)
                        }
                    }
                    HStack {
                        ForEach(0..<6) { _ in
                            Image(.chairBrown)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/12)

                        }
                    }
                }
                .padding().padding()
                Button("➕ Adicionar Fã") {
                    showingCreateFanSheet = true
                }
                .buttonStyle(.borderedProminent)
                .background {
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 16, bottomTrailingRadius: 16, topTrailingRadius: 0)
                        .foregroundStyle(.theater)
                        .overlay {
                            Image(.movieTheater)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                }
                .overlay {
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 16, bottomTrailingRadius: 16, topTrailingRadius: 0)
                        .strokeBorder(Color.white, lineWidth: 6)
                        .opacity(0.8)
                }
                .frame(maxHeight: .infinity, alignment: .top)
//                .offset(x: -geometry.frame(in: .local).midX * 0.1)

                // so pra saber onde fica os logs
                HStack {
                    Rectangle()
                    Rectangle()
                    Rectangle()

                }
                .frame(height: geometry.size.height * 0.2)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .sheet(isPresented: $showingCreateFanSheet) {
                            CreateFanWindowView(
                                moviesVM: moviesVM, onAddFan: { fanID, snackTimeInt in
                                    let newFan = Fan(id: fanID, snackTime: snackTimeInt, moviesVM: moviesVM)
                                    moviesVM.fans.append(newFan)
                                    newFan.start()
                                    moviesVM.markFanNameAsUsed(fanID)
                                }
                            )
                        }
        }
        .navigationBarBackButtonHidden(true)
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

#Preview {
    ShoppingView(capacity: 3, exibitionTime: 10)

}



