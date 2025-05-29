//
//  Untitled.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 29/05/25.
//

import SwiftUI

struct Log: View {
    let title: String
    let color: Color
    let logs: [LogEntry]
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("DisplayLog")
                .resizable()
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.custom("PixelifySans-Semibold", size: 32))
                    .foregroundStyle(color)
                VStack(spacing: 6) {
                    ForEach(logs.suffix(4).reversed(), id: \.self) { log in
                        Text(log.message)
                            .font(.custom("PixelifySans-Semibold", size: 24))
                            .foregroundStyle(.whiteLog)
                    }
                }
                .clipped()
            }
            .padding(.leading, 50)
        }
    }
}
