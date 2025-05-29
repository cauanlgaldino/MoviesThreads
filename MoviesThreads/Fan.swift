//
//  Fan.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 16/05/25.
//

import Foundation

class Fan: Thread, Identifiable, ObservableObject {
    let id: String
    let moviesVM: MovieSessionViewModel
    let snackTime: TimeInterval
    @Published var status: FanStatus = .fila
    var alive = true
    @Published var endSnackTime = Date()
    @Published var endMovieTime = Date()
    @Published var waitingTime = Date()
    
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
        let newStartWaiting = Date()
        
        DispatchQueue.main.async { [unowned self] in
            mutex.wait()
            moviesVM.fansInSession += 1
            status = .esperando
            waitingTime = newStartWaiting
            moviesVM.appendLog("🎟️ \(id) entrou na sala. Total: \(moviesVM.fansInSession)")
            mutex.signal()
        }
        
    }
    
    func watchMovie() {
        sessionReady.wait()
        
        let newEndMovieTime = Date().addingTimeInterval(moviesVM.exhibitionTime)
        DispatchQueue.main.async { [unowned self] in
            status = .assistindo
            endMovieTime = newEndMovieTime
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
        
        let newEndSnackTime = Date().addingTimeInterval(snackTime)
        
        DispatchQueue.main.async { [unowned self] in
            endSnackTime = newEndSnackTime
            status = .lanchando
            moviesVM.appendLog("🍿 \(id) está lanchando.")
        }
        
        let endTime = Date().addingTimeInterval(snackTime)
        var someValue = 30.0
        while Date() < endTime {
            someValue = sin(someValue)
        }
        
        let newStartWaiting = Date()
        DispatchQueue.main.async { [unowned self] in
            status = .fila
            waitingTime = newStartWaiting
            moviesVM.appendLog("✅ \(id) terminou de lanchar e está aguardando para entrar novamente.")
        }
    }
}
