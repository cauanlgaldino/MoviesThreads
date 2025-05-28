//
//  WindowInit.swift
//  MoviesThreads
//
//  Created by Júlia Saboya on 27/05/25.
//

import SwiftUI

struct GlobalWindowView: View {
    var body: some View {
        Group{
            VStack {
                VStack(alignment: .leading) {
                    Text("Capacidade do Auditório")
                        .font(.headline)
                    TextField("Pessoas", text: .constant(""))
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
                    TextField("Segundos", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                Button("Criar Sala"){
                    
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
//                .padding(.vertical)
            }
            .padding(.vertical, 4)
        }
        .padding()
    }
}

#Preview {
    GlobalWindowView()
}
