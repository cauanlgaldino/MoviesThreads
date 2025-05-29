//
//  LogsView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 29/05/25.
//

import SwiftUI

struct LogsView: View {
    let size: CGSize
    @Binding var logs: [LogEntry]
    
    var body: some View {
        HStack(spacing: 6) {
            Log(title: "Demonstrador", color: .greenDemonstrator, logs: logs)
            Log(title: "Sala", color: .redTheater, logs: logs)
            Log(title: "Fãs", color: .purpleFan, logs: logs)
        }
        .frame(width: size.width,
               height: size.height * LayoutConstants.logHeightRatio,
               alignment: .center)
        .position(x: size.width / 2,
                  y: size.height - size.height * LayoutConstants.logHeightRatio / 2)
        .clipped()
    }
}
