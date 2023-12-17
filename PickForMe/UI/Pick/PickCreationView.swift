//
//  PickCreationView.swift
//  PickForMe
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
                TextField("Name", text: $title)
                    .submitLabel(.done)
                    .onSubmit(create)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: dismiss)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create", action: create)
                        .disabled(title.isEmpty)
                }
            }
            .navigationTitle("New Pick")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.height(200)])
    }
    
    // MARK: - Intents
    
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
