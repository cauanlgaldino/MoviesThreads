//
//  ShoppingView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 27/05/25.
//

import SwiftUI
import Foundation

struct ShoppingView: View {
    @StateObject private var session = MovieSessionViewModel(capacity: 3, exhibitionTime: 30)
    @State private var fanIDGenerator = 0
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                
                ScreenView(size: geometry.size)
                LogsView(size: geometry.size, logs: .constant(session.log))
                DoorView(size: geometry.size)
                ProjectorView(size: geometry.size)
                SeatsView(size: geometry.size)
                HStack {
                    Button("➕ Criar Fã") {
                        fanIDGenerator += 1
                        let fan = Fan(id: "F\(fanIDGenerator)", session: session, snackTime: TimeInterval(Int.random(in: 10...20)))
                        session.fans.append(fan)
                        fan.start()
                        
                    }
                    .buttonStyle(.borderedProminent)
                }
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
    static let projectorWidthRatio: CGFloat = 0.315
    static let projectorHeightRatio: CGFloat = 0.255
    static let seatWidthRatio: CGFloat = 0.09
    static let seatHeightRatio: CGFloat = 0.14
    static let theaterHeightRatio: CGFloat = 0.8
    static let theaterWidthRatio: CGFloat = 0.55
}

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

#Preview {
    ShoppingView()
}
