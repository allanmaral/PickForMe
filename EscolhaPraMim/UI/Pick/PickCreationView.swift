//
//  PickCreationView.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

struct PickCreationView: View {
    @Environment(\.dismiss) private var onDismiss
    @State private var title: String = ""
    
    var onCreate: (_ title: String) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome", text: $title)
                    .submitLabel(.done)
                    .onSubmit(create)
            }
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar", action: dismiss)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Criar", action: create)
                        .disabled(title.isEmpty)
                }
            })
            .navigationTitle("Nova Escolha")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.fraction(0.2)])
    }
    
    func create() {
        guard !title.isEmpty else { return }
        onCreate(title)
    }
    
    func dismiss() {
        onDismiss()
    }
}

#Preview {
    Text("Sample")
        .sheet(isPresented: .constant(true)) {
            PickCreationView() { _ in }
        }
}
