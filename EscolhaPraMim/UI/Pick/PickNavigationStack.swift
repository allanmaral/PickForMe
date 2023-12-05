//
//  PickNavigationStack.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 01/12/23.
//

import SwiftUI

struct PickNavigationStack: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path: [Pick] = []
    @State private var sortOrder = SortDescriptor(\Pick.updatedAt, order: .reverse)
    @State private var searchText = ""
    @State private var showCreatePick = false
    @State private var editingPick: Pick?
    
    var body: some View {
        NavigationStack(path: $path) {
            PickListingView(searchString: searchText, sort: sortOrder, onEditPick: showEditForm)
                .searchable(text: $searchText)
                .toolbar {
                    sortPicker
                    Button("Criar Escolha", systemImage: "plus", action: showCreationForm)
                }
                .navigationTitle("Escolha pra mim!")
                .navigationDestination(for: Pick.self) { pick in
                    PickDetailView(pick: pick)
                }
                .sheet(isPresented: $showCreatePick) {
                    PickCreationView(onCreate: createPick)
                }
                .sheet(item: $editingPick) { pick in
                    PickEditView(pick: pick)
                }
        }
    }
    
    var sortPicker: some View {
        Menu("Ordenar", systemImage: "arrow.up.arrow.down") {
            Picker("Ordenar", selection: $sortOrder) {
                Text("Ordenar por Nome")
                    .tag(SortDescriptor(\Pick.title))
                
                Text("Ordernar por Data")
                    .tag(SortDescriptor(\Pick.updatedAt))
            }
            .pickerStyle(.inline)
        }
    }
    
    func showCreationForm() {
        showCreatePick = true
    }
    
    func showEditForm(for pick: Pick) {
        editingPick = pick
    }
    
    func createPick(_ title: String) {
        let pick = Pick(title)
        modelContext.insert(pick)
        path = [pick]
        showCreatePick = false
    }
}

#Preview {
    PickNavigationStack()
        .mockPickDataContainer()
}
