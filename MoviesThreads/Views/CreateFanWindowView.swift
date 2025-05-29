
//import SwiftUI
//
//struct CreateFanWindowView: View {
//    // 1. Variáveis de estado para os TextFields
//    @State private var fanName: String = ""
//    @State private var snackTimeString: String = ""
//
//    // 2. Closure para enviar os dados do fã de volta
//    var onAddFan: (String, Int) -> Void
//
//    // 3. Environment para fechar a sheet
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        // Envolver em um NavigationView para ter um botão de fechar ou título
//        NavigationStack { // Ou NavigationStack se for iOS 16+
//            Group {
//                VStack {
//                    VStack(alignment: .leading) {
//                        Text("Nome do Fã")
//                            .font(.headline)
//                        TextField("Identificador", text: $fanName) // Ligado ao @State fanName
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//                    .padding()
//                    .background(.ultraThinMaterial)
//                    .cornerRadius(10)
//                    .shadow(radius: 5)
//                    .padding(.bottom, 10)
//
//
//                    VStack(alignment: .leading) {
//                        Text("Tempo de Lanche")
//                            .font(.headline)
//                        TextField("Segundos", text: $snackTimeString) // Ligado ao @State snackTimeString
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            
//                    }
//                    .padding()
//                    .background(.ultraThinMaterial)
//                    .cornerRadius(10)
//                    .shadow(radius: 5)
//
//                    Button("Criar Fã") {
//                        // 4. Lógica de validação e chamada do closure
//                        if let snackTime = Int(snackTimeString), !fanName.isEmpty {
//                            onAddFan(fanName, snackTime) // Chama o closure com os dados
//                            dismiss() // Fecha a sheet
//                        } else {
//                            print("Por favor, insira um nome e um tempo de lanche válidos.")
//                            // Opcional: mostrar um alerta para o usuário
//                        }
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .padding()
//                    // Desabilitar o botão se os campos não forem válidos
//                    .disabled(fanName.isEmpty || Int(snackTimeString) == nil || Int(snackTimeString)! <= 0)
//                }
//                .padding(.vertical)
//            }
//            .padding()
//            .navigationTitle("Novo Fã") // Título da janela
////            .navigationBarTitleDisplayMode(.inline)
//            .toolbar { // Adiciona um botão de fechar
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancelar") {
//                        dismiss() // Fecha a sheet
//                    }
//                }
//            }
//        }
//    }
//}
//
//// Preview da CreateFanWindowView. Note que precisamos fornecer um closure vazio para o preview.
//#Preview {
//    CreateFanWindowView(onAddFan: { _, _ in })
//}

import SwiftUI

struct CreateFanWindowView: View {
    // 1. Não usaremos mais fanName como String simples.
    @State private var selectedFanName: String = "" // Para o nome selecionado no Picker
    @State private var snackTime: Int = 5 // Stepper começa em 5

    // 2. Lista de nomes disponíveis para o Picker, passada como Binding
    @ObservedObject var moviesVM: MovieSessionViewModel

    var onAddFan: (String, Int) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Group {
                VStack {
                    // 3. Picker para escolher o nome do fã
                    VStack(alignment: .leading) {
                        Text("Nome do Fã")
                            .font(.headline)
                        Picker("Escolha um nome", selection: $selectedFanName) {
                            ForEach(moviesVM.availableNames, id: \.self) { name in
                                Text(name).tag(name)
                            }
                        }
                         
                        .disabled(moviesVM.availableNames.isEmpty) // Desabilita se não houver nomes
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.bottom, 10)
                    // 4. Inicializa o selectedFanName com o primeiro nome disponível
                    .onAppear {
                        if selectedFanName.isEmpty && !moviesVM.availableNames.isEmpty {
                            selectedFanName = moviesVM.availableNames[0]
                        }
                    }

                    // 5. Stepper para o tempo de lanche
                    VStack(alignment: .leading) {
                        Text("Tempo de Lanche: \(snackTime) Segundos") // Mostra o valor atual
                            .font(.headline)
                        Stepper("Ajustar Tempo", value: $snackTime, in: 1...60) // Começa em 1, máximo de 60 segundos
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 5)

//                    Button("Criar Fã") {
//                        // 6. Lógica de validação e chamada do closure
//                        if !selectedFanName.isEmpty && snackTime > 0 {
//                            onAddFan(selectedFanName, snackTime) // Passa o nome selecionado e o tempo do stepper
//                            dismiss() // Fecha a sheet
//                        } else {
//                            print("Por favor, selecione um nome e um tempo de lanche válido.")
//                            // Opcional: mostrar um alerta
//                        }
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .padding()
//                    .disabled(selectedFanName.isEmpty || snackTime <= 0)
                }
                .padding(.vertical)
            }
//            .padding()
            .navigationTitle("Novo Fã")
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
//                    .buttonStyle(.borderedProminent)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Criar Fã") {
                        // 6. Lógica de validação e chamada do closure
                        if !selectedFanName.isEmpty && snackTime > 0 {
                            onAddFan(selectedFanName, snackTime) // Passa o nome selecionado e o tempo do stepper
                            dismiss() // Fecha a sheet
                        } else {
                            print("Por favor, selecione um nome e um tempo de lanche válido.")
                            // Opcional: mostrar um alerta
                        }
                    }
                    .buttonStyle(CustomRoundedButton())
//                    .padding()
                    .disabled(selectedFanName.isEmpty || snackTime <= 0)
                }
            }
        }
    }
}
//
//// Preview da CreateFanWindowView
//#Preview {
//    // Para o preview, forneça um Binding de exemplo com nomes
//    @State var previewNames = MovieSessionViewModel.allFanNames
//    return CreateFanWindowView(availableNames: $previewNames, onAddFan: { _, _ in })
//}
