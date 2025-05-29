import SwiftUI

struct GlobalWindowView: View {
    @State private var capacityString: String = ""
    @State private var durationString: String = ""

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader{ geo in
                VStack(spacing: 20) {
                    Text("🎬🎬🎬")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                    Text("Exibição do Filme do Pelé")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Capacidade do Auditório")
                            .font(.headline)
                            .padding([.bottom, .leading], 2)
                            
                        TextField("Pessoas", text: $capacityString)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.bottom, 10)
                    .frame(width: geo.size.width * 0.6, alignment: .top)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Duração do filme")
                            .font(.headline)
                            .padding([.bottom, .leading], 2)
                        TextField("Segundos", text: $durationString)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(width: geo.size.width * 0.6, alignment: .center)
                    Button("Criar Sala") {
                        if let newCapacity = Int(capacityString), newCapacity > 0,
                           let newDuration = Int(durationString), newDuration > 0 {
                            path.append(SessionConfiguration(capacity: newCapacity, exhibitionTime: newDuration))
                        } else {
                            print("Por favor, insira valores numéricos positivos válidos.")
                        }
                    }
                    .buttonStyle(CustomRoundedButton())
                    .padding(.top)
                    .disabled(Int(capacityString) == nil || Int(capacityString)! <= 0 || Int(durationString) == nil || Int(durationString)! <= 0)
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .padding() // Padding geral para o conteúdo da View
                .navigationDestination(for: SessionConfiguration.self) { config in
                    MovieSessionView(capacity: config.capacity, exibitionTime: config.exhibitionTime)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct CustomRoundedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.title2)
            .padding(.horizontal, 30) // Increased horizontal padding for width
            .padding(.vertical, 15)   // Increased vertical padding for height
            .background(Color.accentColor)  // Example background color
            .cornerRadius(8)        // Rounded corners for a softer look
            .foregroundColor(.white) // Example text color
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Subtle press effect
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed) // Smooth animation
//            .border(.bar, width: 2)
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
