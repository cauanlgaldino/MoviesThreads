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
    var status: FanStatus = .fila
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
            
            watchMovie()
            
            fanGoesToSnack()
        }
        
        DispatchQueue.main.async { [unowned self] in
            moviesVM.fans.remove(at: moviesVM.fans.firstIndex(where: { $0.id == self.id })!)
            moviesVM.appendLog("🗑️ Fã \(self.id) foi removido da lista de simulação.")            
        }
        
    }
    
    func fanWantsToJoin() {
        roomCapacitySemaphore.wait()
        
        
        DispatchQueue.main.async { [unowned self] in
            mutex.wait()
            moviesVM.fansInSession += 1
            status = .esperando
            moviesVM.appendLog("🎟️ Fã \(id) entrou na sala. Total: \(moviesVM.fansInSession)")
            mutex.signal()
        }
        
    }
    
    func watchMovie() {
        sessionReady.wait()
        
        DispatchQueue.main.async { [unowned self] in
            status = .assistindo
        }
        
        let endTime = Date().addingTimeInterval(moviesVM.exhibitionTime)
        var someValue = 30.0
        while Date() < endTime {
            someValue = sin(someValue)
        }
        
        movieOver.wait()
        
        DispatchQueue.main.async { [unowned self] in
            moviesVM.appendLog("🍿 Fã \(id) terminou de assistir o filme.")
        }
    }
    
    func fanGoesToSnack() {
        
        DispatchQueue.main.async { [unowned self] in
            mutex.wait()
            moviesVM.fansInSession -= 1
            roomCapacitySemaphore.signal()
            moviesVM.appendLog("🚪 Fã \(id) saiu da sala.")
            mutex.signal()
        }
        
        
        DispatchQueue.main.async { [unowned self] in
            status = .lanchando
            moviesVM.appendLog("🍿 Fã \(id) está lanchando.")
        }
        
        let endTime = Date().addingTimeInterval(snackTime)
        var someValue = 30.0
        while Date() < endTime {
            someValue = sin(someValue)
        }
        
        DispatchQueue.main.async { [unowned self] in
            status = .fila
            moviesVM.appendLog("✅ Fã \(id) terminou de lanchar e está aguardando para entrar novamente.")
        }
    }
}
