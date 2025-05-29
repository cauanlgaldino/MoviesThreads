//
//  MoviesViewModel.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 16/05/25.
//

import Foundation
import Combine

enum FanStatus: String {
    case fila = "Na Fila"
    case esperando = "Esperando Filme"
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
    @Published var capacity: Int = 0
    @Published var exhibitionTime: TimeInterval = 0
    
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
    @Published var availableNames: [String] = MovieSessionViewModel.allFanNames
    static let allFanNames: [String] = [
        "Garrincha", "Ronaldo", "Zico", "Rivelino", "Romário",
        "Sócrates", "Ronaldinho", "Neymar Jr.", "Jairzinho", "Falcão"
    ]

    init(capacity: Int, exhibitionTime: Int) {
        self.capacity = capacity
        self.exhibitionTime = TimeInterval(exhibitionTime)
        
        roomCapacitySemaphore = DispatchSemaphore(value: capacity)
        
        let demonstrator = Demonstrator(moviesVM: self)
        demonstrator.start()
    }
    
    func markFanNameAsUsed(_ name: String) {
            if let index = availableNames.firstIndex(of: name) {
                availableNames.remove(at: index)
            }
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
    }
}
