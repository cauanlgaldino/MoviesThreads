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
    var status: FanStatus = .fila // começa na fila
    var alive = true
    
    init(id: String, session: MovieSessionViewModel, snackTime: TimeInterval) {
        self.id = id
        self.moviesVM = session
        self.snackTime = snackTime
        super.init()
        self.name = "Fã \(id)"
    }
    
    override func main() {
        while alive {
            fanWantsToJoin()
//            if !alive { break }
            
            waitForMovieToEnd()
//            if !alive { break }
            
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
//        let endTime = Date().addingTimeInterval(moviesVM.exhibitionTime)
//        var someValue = 100.0  // Variável para a operação matemática.
//        while Date() < endTime {
//                    someValue = sin(someValue)
//                }
        
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
        
        let endTime = Date().addingTimeInterval(snackTime)
        var someValue = 100.0  // Variável para a operação matemática.
        while Date() < endTime {
                    someValue = sin(someValue)
                }

        DispatchQueue.main.async { [unowned self] in
            status = .fila
            moviesVM.appendLog("✅ Fã \(id) terminou de lanchar e está aguardando para entrar novamente.")
        }
    }
}
