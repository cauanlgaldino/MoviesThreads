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
                .scaledToFill()
                .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.custom("PixelifySans-Semibold", size: 28))
                    .foregroundStyle(color)
                    .padding(.leading, 32)

                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(logs, id: \.self) { log in
                            Text(log.message)
                                .font(.custom("PixelifySans-Semibold", size: 20))
                                .foregroundStyle(.whiteLog)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 8)
                }
                .frame(maxHeight: .infinity)
                .clipped()
            }
            .padding(.top, 4)
        }
    }
}
