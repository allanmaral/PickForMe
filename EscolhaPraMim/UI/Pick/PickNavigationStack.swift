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
                .toolbar { toolbar }
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
    
    @ViewBuilder
    var toolbar: some View {
        sortPicker
        Button("Nova escolha", systemImage: "plus", action: showCreationForm)
    }
    
    var sortPicker: some View {
        Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $sortOrder) {
                Text("Título")
                    .tag(SortDescriptor(\Pick.title))
                
                Text("Data")
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
