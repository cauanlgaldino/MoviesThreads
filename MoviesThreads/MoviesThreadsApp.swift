//
//  MoviesThreadsApp.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 13/05/25.
//

import SwiftUI

@main
struct MoviesThreadsApp: App {
    var body: some Scene {
        WindowGroup {
            GlobalWindowView()
        }
//        .windowStyle(.titleBar) // Estilo padrão com barra de título
//        .defaultPosition(.center)
//        .windowLevel(.floating)
//        .windowResizability(.contentSize)
    }
}


#Preview {
    GlobalWindowView()
}
