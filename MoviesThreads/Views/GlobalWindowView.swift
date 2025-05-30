import SwiftUI

struct GlobalWindowView: View {
    @State private var capacityString: String = ""
    @State private var durationString: String = ""

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader{ geo in
                VStack(spacing: 20) {
                        
                    Text(
                        """
                        🎬🎬🎬
                        Exibição do Filme do Pelé
                        """)
                    .multilineTextAlignment(.center)
                    
                    .lineSpacing(8)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                        
                    VStack(alignment: .leading) {
                        Text("Capacidade do Auditório")
                            .font(.headline)
                            .padding([.bottom, .leading], 2)
                            
                        TextField("Pessoas", text: $capacityString)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    .padding(24)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 5, x: 3, y: 3)
                    .frame(width: geo.size.width * 0.25)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Duração do filme")
                            .font(.headline)
                            .padding([.bottom, .leading], 2)
                        TextField("Segundos", text: $durationString)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    .padding(24)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(width: geo.size.width * 0.25)
                    .padding(.bottom)
                    
                    Button("Criar Sala") {
                        if let newCapacity = Int(capacityString), newCapacity > 0,
                           let newDuration = Int(durationString), newDuration > 0 {
                            path.append(SessionConfiguration(capacity: newCapacity, exhibitionTime: newDuration))
                        } else {
                            print("Por favor, insira valores numéricos positivos válidos.")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                    .disabled(Int(capacityString) == nil || Int(capacityString)! <= 0 || Int(durationString) == nil || Int(durationString)! <= 0)
                    .keyboardShortcut(.defaultAction)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .navigationDestination(for: SessionConfiguration.self) { config in
                    ShoppingView(capacity: config.capacity, exibitionTime: config.exhibitionTime)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct SessionConfiguration: Hashable, Identifiable {
    let id = UUID()
    let capacity: Int
    let exhibitionTime: Int
}

#Preview {
    GlobalWindowView()
}
