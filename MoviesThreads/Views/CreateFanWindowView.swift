//
//  WindowInit.swift
//  MoviesThreads
//
//  Created by Júlia Saboya on 27/05/25.
//

import SwiftUI

struct CreateFanWindowView: View {
    var body: some View {
        Group {
            VStack {
                VStack(alignment: .leading) {
                    Text("Nome do Fã")
                        .font(.headline)
                    TextField("Identificador", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)
                

                VStack(alignment: .leading) {
                    Text("Tempo de Lanche")
                        .font(.headline)
                    TextField("Segundos", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                Button("Criar Fã"){
                    
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding(.vertical)
        }
        
        .padding()
    }
}

#Preview {
    CreateFanWindowView()
}
