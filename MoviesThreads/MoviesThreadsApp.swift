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
                .frame(width: 1209.6, height: 785.6)
        }
        .defaultLaunchBehavior(.presented)
        .defaultPosition(.center)
        .defaultSize(width: 1209.6, height: 785.6)
        .windowResizability(.contentSize)
        
    }
}


#Preview {
    GlobalWindowView()
}
