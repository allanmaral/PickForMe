//
//  PickEditView.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 01/12/23.
//

import SwiftUI

struct PickEditView: View {
    @Environment(\.dismiss) private var onDismiss
    @State private var title: String = ""
    @FocusState private var isFieldFocused
    
    var pick: Pick
    
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
                    Button("Cancelar", action: dismiss)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar", action: save)
                        .disabled(title.isEmpty)
                }
            })
            .navigationTitle("Editar Escolha")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isFieldFocused = true
                title = pick.title
            }
        }
        .presentationDetents([.fraction(0.2)])
    }
    
    // MARK: - Intents
    
    func save() {
        guard !title.isEmpty else { return }
        pick.set(title: title)
        onDismiss()
    }
    
    func dismiss() {
        onDismiss()
    }
}

#Preview {
    ModelPreview { pick in
        Text("Sample")
            .sheet(isPresented: .constant(true)) {
                PickEditView(pick: pick)
            }
    }
}
