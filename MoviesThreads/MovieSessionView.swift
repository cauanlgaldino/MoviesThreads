//
//  ContentView.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 13/05/25.
//

import SwiftUI

struct MovieSessionView: View {
    let initialCapacity: Int
    let initialExhibitionTime: Int

    @ObservedObject private var moviesVM: MovieSessionViewModel
    
    @State private var showingCreateFanSheet = false

    init(capacity: Int, exibitionTime: Int) {
        self.initialCapacity = capacity
        self.initialExhibitionTime = exibitionTime
        self.moviesVM = MovieSessionViewModel(capacity: capacity, exhibitionTime: exibitionTime)
    }

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                Text("🎥 Sessão de Filme")
                    .font(.largeTitle.bold())

                HStack {
                    Text("Demonstrador:")
                    Text(moviesVM.demonstratorStatus.rawValue)
                        .fontWeight(.bold)
                        .foregroundColor(moviesVM.demonstratorStatus == .exibindo ? .green : .gray)
                }

                VStack {
                    Text("Fãs na Simulação:")
                        .font(.headline)

                    ForEach(moviesVM.fans) { fan in
                        HStack {
                            Text("👤 \(fan.id)")

                            Spacer()

                            Text(fan.status.rawValue)
                                .foregroundColor(color(for: fan.status))
                            Image(systemName: icon(for: fan.status))

                            Spacer()

                            Button {
                                moviesVM.removeFan(fan)
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
                        ForEach(moviesVM.log.reversed()) { entry in
                            Text(
                                """
                                \(entry.message)
                                """)
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
                    Button("➕ Adicionar Fã") {
                        showingCreateFanSheet = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(20)
            .frame(width: geo.size.width, height: geo.size.height)

            .sheet(isPresented: $showingCreateFanSheet) {
                            CreateFanWindowView(
                                moviesVM: moviesVM, onAddFan: { fanID, snackTimeInt in
                                    let newFan = Fan(id: fanID, snackTime: snackTimeInt, moviesVM: moviesVM)
                                    moviesVM.fans.append(newFan)
                                    newFan.start()
                                    moviesVM.markFanNameAsUsed(fanID)
                                }
                            )
                        }
        }
        .navigationBarBackButtonHidden(true)
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
    MovieSessionView(capacity: 3, exibitionTime: 10)
}
