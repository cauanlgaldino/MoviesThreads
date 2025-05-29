//
//  ProjectorView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 29/05/25.
//

import SwiftUI

struct ProjectorView: View {
    let size: CGSize
    
    var body: some View {
        Image("Pele")
            .resizable()
            .frame(width: size.width * LayoutConstants.projectorWidthRatio,
                   height: size.height * LayoutConstants.projectorHeightRatio)
            .position(x: size.width / 2,
                      y: size.height * LayoutConstants.screenHeightRatio / 2
                      - size.height * LayoutConstants.projectorHeightRatio/1.5)
    }
}
