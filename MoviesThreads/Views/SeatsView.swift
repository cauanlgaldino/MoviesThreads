//
//  SeatsView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 29/05/25.
//

import SwiftUI

struct SeatsView: View {
    let size: CGSize
    
    var body: some View {
        ForEach(0..<10) { index in
            Image("ChairBrown")
                .resizable()
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
