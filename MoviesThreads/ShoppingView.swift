import SwiftUI
import Foundation

struct ShoppingView: View {
    let initialCapacity: Int
    let initialExhibitionTime: Int
    
    @ObservedObject var moviesVM: MovieSessionViewModel
    @State private var showingCreateFanSheet = false
    
    @State private var chairPositions: [Int : CGPoint] = [:]
    //    @State private var burguerPositions: [Int : CGPoint] = [:]
    @State var beingEated: [Bool] = Array(repeating: false, count: 10)
    @State private var queuePositions: [Int : CGPoint] = [:]
    @State private var snackPositions: [Int : CGPoint] = [:]
    
    init(capacity: Int, exibitionTime: Int) {
        self.initialCapacity = capacity
        self.initialExhibitionTime = exibitionTime
        self.moviesVM = MovieSessionViewModel(capacity: capacity, exhibitionTime: exibitionTime)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                
                VStack(spacing: 0) {
                    Image(.pele)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/3)
                        .padding()
                    
                    
                    HStack {
                        ForEach(0..<5, id: \.self) { index in
                            Image(.chairBrown)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/12)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear
                                            .onAppear {
                                                let midX = geo.frame(in: .global).midX
                                                let midY = geo.frame(in: .global).midY
                                                
                                                DispatchQueue.main.async {
                                                    chairPositions[index + 1] = CGPoint(x: midX, y: midY)
                                                }
                                            }
                                    }
                                )
                        }
                    }
                    
                    HStack {
                        ForEach(5..<11, id: \.self) { index in
                            Image(.chairBrown)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/12)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear
                                            .onAppear {
                                                let midX = geo.frame(in: .global).midX
                                                let midY = geo.frame(in: .global).midY
                                                
                                                DispatchQueue.main.async {
                                                    chairPositions[index + 1] = CGPoint(x: midX, y: midY)
                                                }
                                            }
                                    }
                                )
                        }
                    }
                }
                .padding().padding()
                .background {
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 16, bottomTrailingRadius: 16, topTrailingRadius: 0)
                        .foregroundStyle(.theater)
                        .overlay {
                            Image(.movieTheater)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                }
                .overlay {
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 16, bottomTrailingRadius: 16, topTrailingRadius: 0)
                        .strokeBorder(Color.white, lineWidth: 6)
                        .opacity(0.8)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                
                HStack {
                    VStack(spacing: -geometry.size.height/7){
                        Image(.barracaNova)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/6, height: geometry.size.height/2)
                        
                        
                        Image(.barracaNova)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/6, height: geometry.size.height/2)
                    }
                    .overlay {
                        GeometryReader { geo in
                            VStack(spacing: -25) {
                                ForEach(0..<10) { index in
                                    Snack(proxy: geo, index: index) { reportedIndex, position in
                                        DispatchQueue.main.async {
                                            snackPositions[reportedIndex] = position
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.top, -geometry.size.height/20)
                    .padding(.trailing, -geometry.size.width/35)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                
                ForEach(Array(moviesVM.fans.enumerated()), id: \.element.id) { index, fan in
                    FanView(fan: fan, now: moviesVM.now, size: geometry.size)
                        .position(
                            getPosition(for: fan, index: index)
                        )
                        .animation(.easeInOut(duration: 1.0), value: fan.status)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(5..<10, id: \.self) { index in
                            Rectangle()
                                .fill(.clear)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/13)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear
                                            .onAppear {
                                                let origin = geo.frame(in: .global).origin
                                                DispatchQueue.main.async {
                                                    // Ajuste para o centro da área da fila
                                                    queuePositions[index + 1] = CGPoint(x: origin.x + geo.size.width / 2, y: origin.y + geo.size.height / 2)
                                                }
                                            }
                                    }
                                )
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        ForEach(0..<5, id: \.self) { index in
                            Rectangle()
                                .fill(.clear)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/13)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear
                                            .onAppear {
                                                let origin = geo.frame(in: .global).origin
                                                DispatchQueue.main.async {
                                                    // Ajuste para o centro da área da fila
                                                    queuePositions[index + 1] = CGPoint(x: origin.x + geo.size.width / 2, y: origin.y + geo.size.height / 2)
                                                }
                                            }
                                    }
                                )
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, +geometry.size.width/20)
                
                LogsView(size: geometry.size, moviesVM: moviesVM)
                
                Button {
                    showingCreateFanSheet = true
                } label: {
                    VStack(spacing: -4) {
                        Text("Adicionar Fã")
                            .font(.custom("PixelifySans-Semibold", size: 20))
                            .fontWeight(.medium)
                        Text("＋")
                            .font(.custom("PixelifySans-Semibold", size: 20))
                            .fontWeight(.semibold)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 24)
                    .background(Color.red.mix(with: .white, by: 0.05))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.mix(with: .white, by: 0.3), lineWidth: 4)
                    )
                    .shadow(radius: 10)
                }
                .buttonStyle(.plain)
                .frame(height: geometry.size.height * 0.5)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(x: -12, y: -5)
                .keyboardShortcut(.defaultAction)
            }
            .sheet(isPresented: $showingCreateFanSheet) {
                CreateFanWindowView(
                    moviesVM: moviesVM, onAddFan: { fanID, snackTimeInt in
                        let newFan = Fan(id: fanID, snackTime: snackTimeInt, moviesVM: moviesVM)
                        moviesVM.fans.append(newFan)
                        newFan.start()
                        moviesVM.markFanNameAsUsed(fanID)
                    }
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func getQueuePosition(of queueCount: Int) -> CGPoint? {
        return queuePositions[queueCount]
    }
    
    func getChairPosition(of chairCount: Int) -> CGPoint {
        return chairPositions[chairCount] ?? CGPoint.zero
    }
    
    func getPosition(for fan: Fan, index: Int) -> CGPoint {
        switch fan.status {
        case .fila:
            let fansInQueue = moviesVM.fans.filter { $0.status == .fila }.sorted(by: { $0.id < $1.id })
            if let fanIndexInQueue = fansInQueue.firstIndex(where: { $0.id == fan.id }) {
                let queuePositionIndex = fanIndexInQueue + 1
                if let queuePos = queuePositions[queuePositionIndex] {
                    return queuePos
                }
            }
            return CGPoint(x: -100, y: -100)
            
        case .esperando, .assistindo:
            let fansInRoom = moviesVM.fans.filter { $0.status == .esperando || $0.status == .assistindo }.sorted(by: { $0.id < $1.id })
            if let fanIndexInRoom = fansInRoom.firstIndex(where: { $0.id == fan.id }) {
                let chairPositionIndex = fanIndexInRoom + 1
                if let chairPos = chairPositions[chairPositionIndex] {
                    return CGPoint(x: chairPos.x - 45, y: chairPos.y - 52)
                }
            }
            return CGPoint(x: -100, y: -100)
            
        case .lanchando:
            let fansSnacking = moviesVM.fans.filter { $0.status == .lanchando }.sorted(by: { $0.id < $1.id })
            if let fanIndexInSnack = fansSnacking.firstIndex(where: { $0.id == fan.id }) {
                let snackPositionIndex = fanIndexInSnack // Indexa a partir de 0
                if let snackPos = snackPositions[snackPositionIndex] {
                    return snackPos
                }
            }
            
            return CGPoint(x: -100, y: -100)
        }
    }
    
    func chairId(for index: Int) -> Int {
        return index + 1
    }
}

struct LayoutConstants {
    static let screenWidthRatio: CGFloat = 0.55
    static let screenHeightRatio: CGFloat = 0.64
    static let logWidthRatio: CGFloat = 0.33
    static let logHeightRatio: CGFloat = 0.19
    static let doorWidthRatio: CGFloat = 0.03
    static let doorHeightRatio: CGFloat = 0.2
    static let projectorWidthRatio: CGFloat = 0.315
    static let projectorHeightRatio: CGFloat = 0.255
    static let seatWidthRatio: CGFloat = 0.09
    static let seatHeightRatio: CGFloat = 0.14
    static let theaterHeightRatio: CGFloat = 0.8
    static let theaterWidthRatio: CGFloat = 0.55
}

#Preview {
    ShoppingView(capacity: 3, exibitionTime: 10)
        .frame(width: 1512/2, height: 982/2)
    
}
