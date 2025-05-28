//
//  WindowInit.swift
//  MoviesThreads
//
//  Created by Júlia Saboya on 27/05/25.
//

import SwiftUI

struct GlobalWindowView: View {
    @State private var capacityString: String = ""
    @State private var durationString: String = ""

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                VStack(alignment: .leading) {
                    Text("Capacidade do Auditório")
                        .font(.headline)
                    TextField("Pessoas", text: $capacityString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.bottom, 10)


                VStack(alignment: .leading) {
                    Text("Duração do filme")
                        .font(.headline)
                    TextField("Segundos", text: $durationString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)

                Button("Criar Sala") {
                    
                    if let newCapacity = Int(capacityString), newCapacity > 0,
                       let newDuration = Int(durationString), newDuration > 0 {
                        path.append(SessionConfiguration(capacity: newCapacity, exhibitionTime: newDuration))
                    } else {
                        print("Por favor, insira valores numéricos positivos válidos.")
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
                .disabled(Int(capacityString) == nil || Int(capacityString)! <= 0 || Int(durationString) == nil || Int(durationString)! <= 0)
            }
            .padding(.vertical, 4)
            .padding()
            .navigationDestination(for: SessionConfiguration.self) { config in
                MovieSessionView(capacity: config.capacity, exibitionTime: config.exhibitionTime)
            }
        }
    }
}

struct SessionConfiguration: Hashable, Identifiable {
    let id = UUID()
    let capacity: Int
    let exhibitionTime: Int
}

#Preview {
    GlobalWindowView()
}
