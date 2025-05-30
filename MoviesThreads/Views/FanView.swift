//
//  FanView.swift
//  MoviesThreads
//
//  Created by Yane dos Santos on 29/05/25.
//

import SwiftUI
import Foundation

struct FanView: View {
    @ObservedObject var fan: Fan
    let now: Date
    let size: CGSize
    var body: some View {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 11.75)
                        .fill(.timeBackground).opacity(0.58)
                    VStack(alignment: .leading) {
                        Text(fan.id)
                            .font(.system(size: size.width/120))
                        if fan.status == .lanchando || fan.status == .assistindo {
                            Text("Resta: \(getTimeLeft(fan: fan))s")
                                .font(.system(size: size.width/120))
                        } else {
                            Text("Passou: \(getTimeLeft(fan: fan))s")
                                .font(.system(size: size.width/120))
                        }
                        
                    }
                    
                    .padding(8)
                }
                .frame(width: size.width/18, height: size.height/15)
               
                Image(fan.id)
                    .resizable()
                    .frame(width: size.width/20, height: size.height/12)
            }
    }
    
    func getTimeLeft(fan: Fan) -> Int {
        var timeLeft: TimeInterval = 0
        
        switch fan.status {
        case .lanchando:
            timeLeft = fan.endSnackTime.timeIntervalSince(now)
        case .assistindo:
            timeLeft = fan.endMovieTime.timeIntervalSince(now)
        default:
            timeLeft = now.timeIntervalSince(fan.waitingTime) // tempo crescente
        }
        
        if fan.status == .lanchando || fan.status == .assistindo {
            return Int(max((timeLeft), 0))
        } else {
            return Int(max((timeLeft), 0))
        }
    }
}

#Preview {
    FanView(fan: Fan(id: "Zico", snackTime: 5, moviesVM: MovieSessionViewModel(capacity: 5, exhibitionTime: 5)), now: Date(), size: CGSize(width: 1512, height: 982))
}
