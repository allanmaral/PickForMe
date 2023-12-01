//
//  RaffleNavigationStack.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 01/12/23.
//

import SwiftUI

struct RaffleNavigationStack: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Raffle]()
    @State private var sortOrder = SortDescriptor(\Raffle.createdAt, order: .reverse)
    @State private var searchText = ""
    @State private var showCreateRaffle = false
    
    var body: some View {
        NavigationStack {
            RaffleListingView(searchString: searchText, sort: sortOrder)
                .searchable(text: $searchText)
                .toolbar { toolbar }
                .navigationTitle("Escolha pra mim!")
                .navigationDestination(for: Raffle.self) { raffle in
                    RaffleDetailView(raffle: raffle)
                }
                .sheet(isPresented: $showCreateRaffle) {
                    RaffleCreationView(onCreate: createRaffle)
                }
        }
    }
    
    @ViewBuilder
    var toolbar: some View {
        sortPicker
        Button("Criar sorteio", systemImage: "plus", action: showCreationForm)
    }
    
    var sortPicker: some View {
        Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $sortOrder) {
                Text("Título")
                    .tag(SortDescriptor(\Raffle.title))
                
                Text("Data")
                    .tag(SortDescriptor(\Raffle.createdAt))
            }
            .pickerStyle(.inline)
        }
    }
    
    func showCreationForm() {
        showCreateRaffle = true
    }
    
    func createRaffle(_ title: String) {
        let raffle = Raffle(title)
        modelContext.insert(raffle)
        path = [raffle]
        showCreateRaffle = false
    }
}

#Preview {
    RaffleNavigationStack()
        .mockRaffleDataContainer()
}
