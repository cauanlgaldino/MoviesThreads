//
//  Demonstrator.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 16/05/25.
//

import Foundation

class Demonstrator: Thread {
    let moviesVM: MovieSessionViewModel
    
    init(moviesVM: MovieSessionViewModel) {
        self.moviesVM = moviesVM
        super.init()
        self.name = "Demonstrador"
    }
    
    override func main() {
        while true {
            waitUntilRoomFullAndPlayMovie()
        }
    }
    
    func waitUntilRoomFullAndPlayMovie() {
        DispatchQueue.main.async { [unowned self] in
            moviesVM.appendRoomLog("🎬 Demonstrador: Aguardando fãs.")
        }
        
        sessionReady.wait()
        
        DispatchQueue.main.async { [unowned self] in
            moviesVM.demonstratorStatus = .exibindo
            moviesVM.appendRoomLog("🎬 Demonstrador: Sala cheia! Iniciando exibição do filme.")
        }
        
        let endTime = Date().addingTimeInterval(moviesVM.exhibitionTime)
        var value = 30.0
        while Date() < endTime {
            value = sin(value)
        }
        
        
        DispatchQueue.main.async { [unowned self] in
            moviesVM.demonstratorStatus = .aguardandoFas
            moviesVM.appendRoomLog("✅ Demonstrador: Filme terminou.")
        }
        
        for _ in 0..<moviesVM.capacity {
            movieOver.signal()
        }
    }
}
