//
//  Demonstrator.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 16/05/25.
//


import Foundation

class Demonstrator: Thread {
    let moviesVM: MovieSessionViewModel
    
    init(session: MovieSessionViewModel) {
        self.moviesVM = session
    }
    
    override func main() {
        while true {
            waitUntilRoomFullAndPlayMovie()
        }
    }
    
    func waitUntilRoomFullAndPlayMovie() {
        sessionReady.wait()
        DispatchQueue.main.async { [unowned self] in
            moviesVM.demonstratorStatus = .exibindo
            moviesVM.log.append("🎬 Demonstrador: Iniciando exibição do filme.")
        }
        Thread.sleep(forTimeInterval: moviesVM.exhibitionTime)
        
        DispatchQueue.main.async { [unowned self] in
            moviesVM.demonstratorStatus = .aguardando
            moviesVM.log.append("✅ Demonstrador: Filme terminou.")
        }
        
        for _ in 0..<moviesVM.capacity {
            movieOver.signal()
        }
    }
}
