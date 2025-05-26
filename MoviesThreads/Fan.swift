//
//  Fan.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 16/05/25.
//

import Foundation

class Fan: Thread, Identifiable {
    let id: String
    let moviesVM: MovieSessionViewModel
    let snackTime: TimeInterval
    var status: FanStatus = .aguardando
    var alive = true
    
    init(id: String, session: MovieSessionViewModel, snackTime: TimeInterval) {
        self.id = id
        self.moviesVM = session
        self.snackTime = snackTime
    }
    
    override func main() {
        while alive {
            fanWantsToJoin()

            waitForMovieToEnd()
            
            fanGoesToSnack()
        }
    }
    
    func fanWantsToJoin() {
        roomCapacitySemaphore.wait()
        
        mutex.wait() 

        DispatchQueue.main.async { [unowned self] in
            moviesVM.fansInSession += 1
            status = .esperando_filme
            moviesVM.appendLog("🎟️ Fã \(id) entrou na sala. Total: \(moviesVM.fansInSession)")
        }
        
        mutex.signal()
    }
    
    func waitForMovieToEnd() {
        movieOver.wait()
        moviesVM.appendLog("🍿 Fã \(id) terminou de assistir o filme.")
    }
    
    func fanGoesToSnack() {
        mutex.wait()
        
        DispatchQueue.main.async { [unowned self] in
            moviesVM.fansInSession -= 1
            moviesVM.appendLog("🚪 Fã \(id) saiu da sala.")
        }
        
        roomCapacitySemaphore.signal()
        mutex.signal()
        
        DispatchQueue.main.async { [unowned self] in
            status = .lanchando
            moviesVM.appendLog("🍿 Fã \(id) está lanchando.")
        }
        
        Thread.sleep(forTimeInterval: snackTime)
        DispatchQueue.main.async { [unowned self] in
            self.status = .aguardando
            self.moviesVM.appendLog("✅ Fã \(id) terminou de lanchar e está aguardando para entrar novamente.")
        }
    }
}
