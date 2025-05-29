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
    
    init(id: String, snackTime: Int, moviesVM: MovieSessionViewModel) {
        self.id = id
        self.snackTime = TimeInterval(snackTime)
        self.moviesVM = moviesVM
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
            moviesVM.availableNames.append(id)
            moviesVM.appendLog("🗑️ \(self.id) foi removido da lista de simulação.")
        }
        
    }
    
    func fanWantsToJoin() {
        roomCapacitySemaphore.wait()
        
        
        DispatchQueue.main.async { [unowned self] in
            mutex.wait()
            moviesVM.fansInSession += 1
            status = .esperando
            moviesVM.appendLog("🎟️ \(id) entrou na sala. Total: \(moviesVM.fansInSession)")
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
            moviesVM.appendLog("🍿 \(id) terminou de assistir o filme.")
        }
    }
    
    func fanGoesToSnack() {
        
        DispatchQueue.main.async { [unowned self] in
            mutex.wait()
            moviesVM.fansInSession -= 1
            roomCapacitySemaphore.signal()
            moviesVM.appendLog("🚪 \(id) saiu da sala.")
            mutex.signal()
        }
        
        
        DispatchQueue.main.async { [unowned self] in
            status = .lanchando
            moviesVM.appendLog("🍿 \(id) está lanchando.")
        }
        
        let endTime = Date().addingTimeInterval(snackTime)
        var someValue = 30.0
        while Date() < endTime {
            someValue = sin(someValue)
        }
        
        DispatchQueue.main.async { [unowned self] in
            status = .fila
            moviesVM.appendLog("✅ \(id) terminou de lanchar e está aguardando para entrar novamente.")
        }
    }
}
