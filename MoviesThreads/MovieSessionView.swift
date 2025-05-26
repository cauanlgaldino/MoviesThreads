//
//  ContentView.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 13/05/25.
//

import SwiftUI

struct MovieSessionView: View {
    @StateObject private var session = MovieSessionViewModel(capacity: 3, exhibitionTime: 5)
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
                    ForEach(session.log.reversed()) { entry in // Remova 'id: \.self'
                        Text(entry.message) // Acesse a propriedade 'message'
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
                    let fan = Fan(id: "F\(fanIDGenerator)", session: session, snackTime: TimeInterval(Int.random(in: 2...5)))
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
        case .aguardando: return .gray // Cor para o fã aguardando fora da sala
        case .esperando_filme: return .purple // NOVA COR para fã na sala, mas esperando o filme
        case .assistindo: return .blue
        case .lanchando: return .orange
        }
    }
    
    func icon(for status: FanStatus) -> String {
        switch status {
        case .aguardando: return "hourglass"
        case .esperando_filme: return "chair.fill"
        case .assistindo: return "film"
        case .lanchando: return "fork.knife"
        }
    }
}

#Preview {
    MovieSessionView()
}
