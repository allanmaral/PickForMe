//
//  PickEditView.swift
//  PickForMe
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
                TextField("Name", text: $title)
                    .submitLabel(.done)
                    .focused($isFieldFocused)
                    .onSubmit(save)
            }
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: dismiss)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(title.isEmpty)
                }
            })
            .navigationTitle("Edit Pick")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isFieldFocused = true
                title = pick.title
            }
        }
        .presentationDetents([.height(200)])
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
