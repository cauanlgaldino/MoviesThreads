//
//  LogsView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 29/05/25.
//

import SwiftUI

struct LogsView: View {
    let size: CGSize
    @ObservedObject var moviesVM: MovieSessionViewModel

    var body: some View {
        HStack(spacing: 6) {
            Log(title: "Fila", color: .greenDemonstrator, logs: moviesVM.queueLog.reversed())
            Log(title: "Sala", color: .redTheater, logs: moviesVM.roomLog.reversed())
            Log(title: "Lanche", color: .purpleFan, logs: moviesVM.snackLog.reversed())
        }
        .frame(width: size.width,
               height: size.height * LayoutConstants.logHeightRatio,
               alignment: .center)
        .position(x: size.width / 2,
                  y: size.height - size.height * LayoutConstants.logHeightRatio / 2)
        .clipped()
    }
}
