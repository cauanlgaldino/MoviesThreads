//
//  ShoppingView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 27/05/25.
//

import SwiftUI
import Foundation

struct ShoppingView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                ScreenView(size: geometry.size)
                LogsView(size: geometry.size)
                DoorView(size: geometry.size)
                ProjectorView(size: geometry.size)
                SeatsView(size: geometry.size)
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
    static let projectorWidthRatio: CGFloat = 0.36
    static let projectorHeightRatio: CGFloat = 0.29
    static let seatWidthRatio: CGFloat = 0.088
    static let seatHeightRatio: CGFloat = 0.127
}

struct LogsView: View {
    let size: CGSize
    
    var body: some View {
        HStack(spacing: 6) {
            Rectangle()
                .fill(Color.blue)
            Rectangle()
                .fill(Color.red)
            Rectangle()
                .fill(Color.gray)
        }
        .frame(width: size.width,
               height: size.height * LayoutConstants.logHeightRatio,
               alignment: .center)
        .position(x: size.width / 2,
                  y: size.height - size.height * LayoutConstants.logHeightRatio / 2)
    }
}

struct DoorView: View {
    let size: CGSize
    
    var body: some View {
        Rectangle()
            .fill(Color.brown)
            .frame(width: size.width * LayoutConstants.doorWidthRatio,
                   height: size.height * LayoutConstants.doorHeightRatio)
            .position(
                x: size.width / 2
                    - size.width * LayoutConstants.screenWidthRatio / 2
                    - size.width * LayoutConstants.doorWidthRatio / 2,
                y: size.height * LayoutConstants.screenHeightRatio
                    - size.height * LayoutConstants.doorHeightRatio / 2
            )
    }
}

struct ProjectorView: View {
    let size: CGSize
    
    var body: some View {
        Rectangle()
            .fill(Color.cyan)
            .frame(width: size.width * LayoutConstants.projectorWidthRatio,
                   height: size.height * LayoutConstants.projectorHeightRatio)
            .position(x: size.width / 2,
                      y: size.height * LayoutConstants.screenHeightRatio / 2
                        - size.height * LayoutConstants.projectorHeightRatio / 2)
    }
}

struct ScreenView: View {
    let size: CGSize
    
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: size.width * LayoutConstants.screenWidthRatio,
                   height: size.height * LayoutConstants.screenHeightRatio)
            .position(x: size.width / 2,
                      y: size.height * LayoutConstants.screenHeightRatio / 2)
    }
}

struct SeatsView: View {
    let size: CGSize
    
    var body: some View {
        ForEach(0..<10) { index in
            Rectangle()
                .fill(Color.green)
                .border(Color.black)
                .frame(width: size.width * LayoutConstants.seatWidthRatio,
                       height: size.height * LayoutConstants.seatHeightRatio)
                .position(
                    x: seatX(for: index, size: size),
                    y: seatY(for: index, size: size)
                )
        }
    }
    
    private func seatX(for index: Int, size: CGSize) -> CGFloat {
        let seatWidth = size.width * LayoutConstants.seatWidthRatio
            let spacing: CGFloat = 10
            let col = index % 5
            let centerOffset = CGFloat(col - 2)
            
            return size.width / 2 + centerOffset * (seatWidth + spacing)
    }
    
    private func seatY(for index: Int, size: CGSize) -> CGFloat {
        let baseY = size.height * LayoutConstants.screenHeightRatio / 2
        let offsetY = size.height * LayoutConstants.seatHeightRatio
        return index < 5 ? baseY + offsetY / 2 : baseY + offsetY * 1.3
    }
}

#Preview {
    ShoppingView()
}
