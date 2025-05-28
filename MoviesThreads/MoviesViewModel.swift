//
//  MoviesViewModel.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 16/05/25.
//

import Foundation
import Combine

enum FanStatus: String {
    case fila = "Na Fila" // Fora da sala, esperando para tentar entrar
    case esperando = "Esperando Filme" // Entrou na sala, mas o filme não começou
    case assistindo = "Assistindo"
    case lanchando = "Lanchando"
}

enum DemonstratorStatus: String {
    case aguardandoFas = "Aguardando Fãs"
    case exibindo = "Exibindo Filme"
}

let mutex = DispatchSemaphore(value: 1)
let sessionReady = DispatchSemaphore(value: 0)
let movieOver = DispatchSemaphore(value: 0)
var roomCapacitySemaphore: DispatchSemaphore!

struct LogEntry: Identifiable, Hashable {
    let id = UUID()
    let message: String
}

class MovieSessionViewModel: ObservableObject {
    let capacity: Int
    let exhibitionTime: TimeInterval
    
    @Published var demonstratorStatus: DemonstratorStatus = .aguardandoFas
    @Published var fansInSession: Int = 0 {
        didSet {
            if fansInSession == capacity {
                DispatchQueue.main.async { [unowned self] in
                    appendLog("✅ Sala cheia! Sinalizando o demonstrador para iniciar o filme.")
                }
                for _ in 0 ..< capacity+1 {
                    sessionReady.signal()
                }
            }
        }
    }
    @Published var fans: [Fan] = []
    @Published var log: [LogEntry] = []
    
    init(capacity: Int, exhibitionTime: TimeInterval) {
        self.capacity = capacity
        self.exhibitionTime = exhibitionTime
        
        roomCapacitySemaphore = DispatchSemaphore(value: capacity)
        
        let demonstrator = Demonstrator(session: self)
        demonstrator.start()
    }
    
    func appendLog(_ message: String) {
        DispatchQueue.main.async { [unowned self] in
            log.append(LogEntry(message: message))
        }
    }
    
    
    func removeFan(_ fanToRemove: Fan) {
        DispatchQueue.main.async { [unowned self] in
            fanToRemove.alive = false
            appendLog("❌ Fã \(fanToRemove.id) vai ser removido da simulação.")
        }
        
        
//        if let index = self.fans.firstIndex(where: { $0.id == fanToRemove.id }) {
//            self.fans.remove(at: index)
//            self.appendLog("🗑️ Fã \(fanToRemove.id) foi removido da lista de simulação.")
//        }
    }
}
