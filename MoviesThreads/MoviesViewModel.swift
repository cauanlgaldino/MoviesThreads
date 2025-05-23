//
//  FanStatus.swift
//  MoviesThreads
//
//  Created by Cauan Lopes Galdino on 16/05/25.
//


//

import Foundation
import Combine

enum FanStatus: String {
    case aguardando = "Aguardando"
    case assistindo = "Assistindo"
    case lanchando = "Lanchando"
}

enum DemonstratorStatus: String {
    case aguardando = "Aguardando"
    case exibindo = "Exibindo Filme"
}

let mutex = DispatchSemaphore(value: 1)
let sessionReady = DispatchSemaphore(value: 0)
let movieOver = DispatchSemaphore(value: 0)

class MovieSessionViewModel: ObservableObject {
    let capacity: Int
    let exhibitionTime: TimeInterval
    
    @Published var demonstratorStatus: DemonstratorStatus = .aguardando
    @Published var fansInSession: Int = 0
    @Published var fans: [Fan] = []
    @Published var log: [String] = []
    
    init(capacity: Int, exhibitionTime: TimeInterval) {
        self.capacity = capacity
        self.exhibitionTime = exhibitionTime

        let demonstrator = Demonstrator(session: self)
        demonstrator.start()
    }

}
