//
//  WindowInit.swift
//  MoviesThreads
//
//  Created by Júlia Saboya on 27/05/25.
//
import SwiftUI

struct GlobalWindowView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Insira a capacidade máxima da sala")
                TextField("Ex: 5", text: .constant(""))
            }

        VStack(alignment: .leading) {
            Text("Insira a duração do filme em segundos")
            TextField("Ex: 30", text: .constant(""))
        }
    }
        .padding()
    }
}

#Preview {
    GlobalWindowView()
}
