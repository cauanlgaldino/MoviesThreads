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
            moviesVM.appendLog("🎬 Demonstrador: Iniciando exibição do filme.")
            for fan in moviesVM.fans {
                if fan.status == .esperando_filme {
                    fan.status = .assistindo
                }
            }
        }
        
        Thread.sleep(forTimeInterval: moviesVM.exhibitionTime)
        
        DispatchQueue.main.async { [unowned self] in
            moviesVM.demonstratorStatus = .aguardando
            moviesVM.appendLog("✅ Demonstrador: Filme terminou.")
        }
        
        for _ in 0 ..< moviesVM.capacity {
            movieOver.signal()
        }
    }
}
