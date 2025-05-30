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
                .frame(minWidth: 1209.6, minHeight: 785.6)
                .windowResizeBehavior(.disabled)
        }
        .defaultLaunchBehavior(.presented)
        
    }
}


#Preview {
    GlobalWindowView()
}
