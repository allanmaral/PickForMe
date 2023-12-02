//
//  RaffleEditView.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 01/12/23.
//

import SwiftUI

struct RaffleEditView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @FocusState private var isFieldFocused
    
    var raffle: Raffle
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome", text: $title)
                    .submitLabel(.done)
                    .focused($isFieldFocused)
                    .onSubmit(save)
            }
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar", action: { dismiss() })
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar", action: save)
                        .disabled(title.isEmpty)
                }
            })
            .navigationTitle("Editar sorteio")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isFieldFocused = true
                title = raffle.title
            }
        }
        .presentationDetents([.fraction(0.2)])
    }
    
    func save() {
        guard !title.isEmpty else { return }
        raffle.title = title
        raffle.updatedAt = .now
        dismiss()
    }
}

#Preview {
    ModelPreview { raffle in
        Text("Sample")
            .sheet(isPresented: .constant(true)) {
                RaffleEditView(raffle: raffle)
            }
    }
}
