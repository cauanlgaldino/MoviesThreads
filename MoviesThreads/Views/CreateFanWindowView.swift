import SwiftUI

struct CreateFanWindowView: View {
    @State private var selectedFanName: String = ""
    @State private var snackTimeString: String = ""
    @State private var snackTime: Int = 5
    
    @ObservedObject var moviesVM: MovieSessionViewModel
    
    var onAddFan: (String, Int) -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Nome do Fã")
                    .font(.headline)
                Picker("Escolha um nome", selection: $selectedFanName) {
                    ForEach(moviesVM.availableNames, id: \.self) { name in
                        Text(name).tag(name)
                    }
                }
                
                .disabled(moviesVM.availableNames.isEmpty)
            }
            .padding(24)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.bottom, 10)
            .onAppear {
                if selectedFanName.isEmpty && !moviesVM.availableNames.isEmpty {
                    selectedFanName = moviesVM.availableNames[0]
                }
            }
            
            VStack(alignment: .leading) {
                Text("Tempo de Lanche")
                    .font(.headline)
                TextField("Segundos", text: $snackTimeString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            .padding(24)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            
        }
        .padding()
        
        .navigationTitle("Novo Fã")
        .toolbarTitleDisplayMode(.inlineLarge)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") {
                    dismiss()
                }
                
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    if !selectedFanName.isEmpty && Int(snackTimeString) ?? 0 > 0 {
                        onAddFan(selectedFanName, Int(snackTimeString) ?? 0)
                        dismiss()
                    } else {
                        print("Por favor, selecione um nome e um tempo de lanche válido.")
                        
                    }
                }
                .buttonStyle(.borderedProminent)
                
                .disabled(selectedFanName.isEmpty || Int(snackTimeString) == nil || Int(snackTimeString)! <= 0)
            }
        }
    }
}

#Preview {
    CreateFanWindowView(moviesVM: MovieSessionViewModel(capacity: 3, exhibitionTime: 10), onAddFan: { _, _ in })
}
