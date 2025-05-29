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
    @State private var chairPositions: [CGPoint] = []

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
                                .background(
                                            GeometryReader { geo in
                                                Color.clear
                                                    .onAppear {
                                                        let origin = geo.frame(in: .global).origin
                                                        DispatchQueue.main.async {
                                                            chairPositions.append(origin)
                                                        }
                                                    }
                                            }
                                        )
                        }
                    }

                    HStack {
                        ForEach(5..<11) { _ in
                            Image(.chairBrown)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/12)
                                .background(
                                            GeometryReader { geo in
                                                Color.clear
                                                    .onAppear {
                                                        let origin = geo.frame(in: .global).origin
                                                        DispatchQueue.main.async {
                                                            chairPositions.append(origin)
                                                        }
                                                    }
                                            }
                                        )

                        }
                    }
                }
                .padding().padding()
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

                VStack(spacing: -geometry.size.height/10) {
                    Image(.barracaNova)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/6, height: geometry.size.height/2)
                        .padding(.top, -geometry.size.height/20)

                    Image(.barracaNova)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/6, height: geometry.size.height/2)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)

                // so pra saber onde fica os logs
                HStack {
                    Rectangle()
                    Rectangle()
                    Rectangle()

                }
                .frame(height: geometry.size.height * 0.2)
                .frame(maxHeight: .infinity, alignment: .bottom)

                Image(.provisorio)

            }
            .onAppear {
                printChairsPosition()
            }
        }
    }

    func printChairsPosition() {
        var chairCounter: Int = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for chairPosition in chairPositions.reversed() {
                if chairPosition.y < 342 {
                    chairCounter+=1
                    print("\(chairCounter): \(chairPosition)")

                } else {
                    chairCounter+=1
                    print("\(chairCounter): \(chairPosition)")
                }

            }
        }
    }

    func getChairPosition() {
        
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
    ShoppingView()
        .frame(width: 1512, height: 982)

}



