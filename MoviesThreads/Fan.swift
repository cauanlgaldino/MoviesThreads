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
//        status = .aguardando
        mutex.wait()
        if moviesVM.fansInSession < moviesVM.capacity {
            //semadforo com a capacidade para garantir que só entrem x pessoas
            DispatchQueue.main.async { [unowned self] in
                moviesVM.fansInSession += 1
                status = .assistindo
                moviesVM.log.append("🎟️ Fã \(id) entrou na sala. Total: \(moviesVM.fansInSession)")
            }
            if moviesVM.fansInSession < moviesVM.capacity {
                sessionReady.signal()
            }
        }
        mutex.signal()
    }
    
    func waitForMovieToEnd() {
        movieOver.wait()
    }
    
    func fanGoesToSnack() {
        mutex.wait()
        DispatchQueue.main.async { [unowned self] in
            moviesVM.fansInSession -= 1
            moviesVM.log.append("🚪 Fã \(id) saiu da sala.")
        }
        mutex.signal()
        
        DispatchQueue.main.async { [unowned self] in
            status = .lanchando
            moviesVM.log.append("🍿 Fã \(id) está lanchando.")
        }
        
        Thread.sleep(forTimeInterval: snackTime)
    }
}
