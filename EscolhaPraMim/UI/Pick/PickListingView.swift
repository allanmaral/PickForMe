//
//  PickListingView.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

struct PickListingView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Pick.title) var picks: [Pick]
    
    var edit: (Pick) -> Void
    let isSearching: Bool
    
    var body: some View {
        if !picks.isEmpty {
            List {
                ForEach(picks) { pick in
                    PickListItem(pick)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                delete(pick)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                edit(pick)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                }
            }
        } else if isSearching {
            ContentUnavailableView.search
        } else {
            ContentUnavailableView("Nenhuma Escolha", systemImage: "questionmark.app.fill", description: Text("Para adicionar uma escolha, toque no ícone Criar Escolha na barra de ferramentas."))
        }
    }
    
    init(searchString: String, sort: SortDescriptor<Pick>, onEditPick: @escaping (Pick) -> Void) {
        edit = onEditPick
        isSearching = !searchString.isEmpty
        _picks = Query(filter: #Predicate {
            if !isSearching {
                return true
            } else {
                return $0.title.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    func delete(_ pick: Pick) {
        modelContext.delete(pick)
    }
}

#Preview {
    NavigationStack {
        PickListingView(searchString: "", sort: SortDescriptor(\Pick.title)) { _ in }
    }
    .mockPickDataContainer()
}