//
//  ScreenView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 29/05/25.
//

import SwiftUI

struct ScreenView: View {
    let size: CGSize
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.theater)
                .frame(width: size.width * LayoutConstants.screenWidthRatio,
                       height: size.height * LayoutConstants.screenHeightRatio)
            Image("MovieTheater")
                .resizable()
                .frame(width: size.width * LayoutConstants.theaterWidthRatio,
                       height: size.height * LayoutConstants.theaterHeightRatio)
        }
        .position(x: size.width / 2,
                  y: size.height * LayoutConstants.screenHeightRatio / 2)
    }
}
