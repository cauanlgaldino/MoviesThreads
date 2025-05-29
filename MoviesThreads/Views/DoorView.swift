//
//  DoorView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 29/05/25.
//

import SwiftUI

struct DoorView: View {
    let size: CGSize
    
    var body: some View {
        Image("Door")
            .resizable()
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
