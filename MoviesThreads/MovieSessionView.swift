//
//  ContentView.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 13/05/25.
//

import SwiftUI

struct MovieSessionView: View {
    @StateObject private var session = MovieSessionViewModel(capacity: 3, exhibitionTime: 10)
    @State private var fanIDGenerator = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                Text("🎥 Sessão de Filme")
                    .font(.largeTitle.bold())
                
                HStack {
                    Text("Demonstrador:")
                    Text(session.demonstratorStatus.rawValue)
                        .fontWeight(.bold)
                        .foregroundColor(session.demonstratorStatus == .exibindo ? .green : .gray)
                }
                
                VStack {
                    Text("Fãs na Simulação:")
                        .font(.headline)
                    
                    ForEach(session.fans) { fan in
                        HStack {
                            Text("👤 \(fan.id)")
                            
                            Spacer()
                            
                            Text(fan.status.rawValue)
                                .foregroundColor(color(for: fan.status))
                            Image(systemName: icon(for: fan.status))
                            
                            Spacer()
                            
                            Button {
                                session.removeFan(fan)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title2)
                            }
                            .buttonStyle(.plain)
                            .disabled(!fan.alive)
                        }
                        .frame(width: geo.size.width * 0.4)
                        
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                
                VStack(alignment: .leading) {
                    Text("📋 Log de Eventos:")
                        .font(.headline)
                    ScrollView {
                        ForEach(session.log.reversed()) { entry in
                            Text(entry.message)
                                .font(.title3)
                                .padding(.vertical, 4)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(12)
                
                HStack {
                    Button("➕ Criar Fã") {
                        fanIDGenerator += 1
                        let fan = Fan(id: "F\(fanIDGenerator)", session: session, snackTime: TimeInterval(Int.random(in: 1...5)))
                        session.fans.append(fan)
                        fan.start()
                        
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(20)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
    
    func color(for status: FanStatus) -> Color {
        switch status {
        case .fila: return .gray
        case .esperando: return .purple
        case .assistindo: return .blue
        case .lanchando: return .orange
        }
    }
    
    func icon(for status: FanStatus) -> String {
        switch status {
        case .fila: return "hourglass"
        case .esperando: return "chair.fill"
        case .assistindo: return "film"
        case .lanchando: return "fork.knife"
        }
    }
}

#Preview {
    MovieSessionView()
}
