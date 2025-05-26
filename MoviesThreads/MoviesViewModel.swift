//
//  MoviesViewModel.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 16/05/25.
//

import Foundation
import Combine

enum FanStatus: String {
    case aguardando = "Aguardando" // Fora da sala, esperando para tentar entrar
    case esperando_filme = "Esperando Filme" // Entrou na sala, mas o filme não começou
    case assistindo = "Assistindo"
    case lanchando = "Lanchando"
}

enum DemonstratorStatus: String {
    case aguardando = "Aguardando"
    case exibindo = "Exibindo Filme"
}

let mutex = DispatchSemaphore(value: 1) // Para proteger a variável fansInSession
let sessionReady = DispatchSemaphore(value: 0) // Sinalizado quando a sala está cheia para o demonstrador
let movieOver = DispatchSemaphore(value: 0) // Sinalizado quando o filme termina para os fãs
var roomCapacitySemaphore: DispatchSemaphore! // Controla a capacidade da sala

// Nova struct para o item do log, com um ID único
struct LogEntry: Identifiable, Hashable {
    let id = UUID() // Garante um ID único para cada entrada
    let message: String
}

class MovieSessionViewModel: ObservableObject {
    let capacity: Int
    let exhibitionTime: TimeInterval
    
    @Published var demonstratorStatus: DemonstratorStatus = .aguardando
    @Published var fansInSession: Int = 0 {
        didSet {
            if fansInSession == capacity {
                sessionReady.signal()
                DispatchQueue.main.async { [unowned self] in
                    appendLog("✅ Sala cheia! Sinalizando o demonstrador para iniciar o filme.")
                }
            }
        }
    }
    @Published var fans: [Fan] = []
    @Published var log: [LogEntry] = [] // Mudei para [LogEntry]
    
    init(capacity: Int, exhibitionTime: TimeInterval) {
        self.capacity = capacity
        self.exhibitionTime = exhibitionTime

        roomCapacitySemaphore = DispatchSemaphore(value: capacity)
        
        let demonstrator = Demonstrator(session: self)
        demonstrator.start()
    }
    
    func appendLog(_ message: String) {
            DispatchQueue.main.async {
                self.log.append(LogEntry(message: message))
            }
        }

}
