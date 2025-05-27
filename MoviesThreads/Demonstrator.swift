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
        super.init()
        self.name = "Demonstrador"
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
                    }
            moviesVM.appendLog("🎬 Demonstrador: Iniciando exibição do filme.")
            for fan in moviesVM.fans {
                if fan.status == .esperando_filme {
                    fan.status = .assistindo
                    
                }
            }
            let endTime = Date().addingTimeInterval(moviesVM.exhibitionTime)
        var value = 1.0
            while Date() < endTime {
                value = sin(value)
                    }
        
        
        DispatchQueue.main.async { [unowned self] in
            moviesVM.demonstratorStatus = .waitingFans
            moviesVM.appendLog("✅ Demonstrador: Filme terminou.")
        }
        
        for _ in 0 ..< moviesVM.capacity {
            movieOver.signal()
        }
    }
}
