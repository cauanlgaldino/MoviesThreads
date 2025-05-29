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
    @State private var now = Date()
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
            
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    now = Date() // força o redraw a cada segundo
                }
            }
    }
    
    func getTimeLeft(fan: Fan) -> Int {
            var timeLeft: TimeInterval = 0
        
        if fan.status == .lanchando {
            timeLeft = fan.endSnackTime.timeIntervalSince(now)
        } else if fan.status == .assistindo {
            // Exemplo de cálculo do tempo restante do filme (se ativar)
            // let elapsed = Date().timeIntervalSince(fan.startMovieTime)
            // timeLeft = fan.moviesVM.exhibitionTime - elapsed
        }
        
        return Int(max(ceil(timeLeft), 0))
    }
}

#Preview {
    FanView(fan: Fan(id: "Zico", snackTime: 5, moviesVM: MovieSessionViewModel(capacity: 5, exhibitionTime: 5)), size: CGSize(width: 1512, height: 982))
}
