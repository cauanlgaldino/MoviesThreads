//
//  ContentView.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 13/05/25.
//

import SwiftUI

struct MovieSessionView: View {
    @StateObject private var session = MovieSessionViewModel(capacity: 3, exhibitionTime: 30)
    @State private var fanIDGenerator = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🎥 Sessão de Filme")
                .font(.largeTitle.bold())
            
            HStack {
                Text("Demonstrador:")
                Text(session.demonstratorStatus.rawValue)
                    .fontWeight(.bold)
                    .foregroundColor(session.demonstratorStatus == .exibindo ? .green : .gray)
            }
            
            VStack(alignment: .leading) {
                Text("Fãs na Simulação:")
                    .font(.headline)
                
                ForEach(session.fans) { fan in
                    HStack {
                        Text("👤 \(fan.id)")
                        Text(fan.status.rawValue)
                            .foregroundColor(color(for: fan.status))
                        Image(systemName: icon(for: fan.status))
                        
//                        Botão para remover este fã específico
                        Button {
                            session.removeFan(fan)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                                .font(.title2)
                        }
                        .buttonStyle(.plain)
                    }
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
                    }
                }
                .frame(maxHeight: 150)
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(12)
            
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
        .padding()
    }
    
    func color(for status: FanStatus) -> Color {
        switch status {
        case .fila: return .gray
        case .esperando_filme: return .purple
        case .assistindo: return .blue
        case .lanchando: return .orange
        }
    }
    
    func icon(for status: FanStatus) -> String {
        switch status {
        case .fila: return "hourglass"
        case .esperando_filme: return "chair.fill"
        case .assistindo: return "film"
        case .lanchando: return "fork.knife"
        }
    }
}

#Preview {
    MovieSessionView()
}
