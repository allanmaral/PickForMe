//
//  ContentView.swift
//  SelectMate
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Raffle]()
    @State private var sortOrder = SortDescriptor(\Raffle.createdAt, order: .reverse)
    @State private var searchText = ""
    @State private var showCreateRaffle = false
    
    
    var body: some View {
        NavigationStack(path: $path) {
            RaffleListingView(searchString: searchText, sort: sortOrder)
                .navigationTitle("Escolha pra mim!")
                .navigationDestination(for: Raffle.self) { raffle in
                    EditRaffleView(raffle: raffle)
                }
                .searchable(text: $searchText)
                .toolbar {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Title")
                                .tag(SortDescriptor(\Raffle.title))
                            
                            Text("Date")
                                .tag(SortDescriptor(\Raffle.createdAt))
                        }
                        .pickerStyle(.inline)
                    }
                    
                    
                    Button("Add Raffle", systemImage: "plus", action: showCreationForm)
                }
                .sheet(isPresented: $showCreateRaffle) {
                    NavigationStack {
                        CreateRaffleView(onCreate: createRaffle)
                    }
                    .presentationDetents([.fraction(0.3)])
                }
            
        }
    }
    
    func showCreationForm() {
        showCreateRaffle.toggle()
    }
    
    func createRaffle(_ title: String) {
        let raffle = Raffle(title)
        modelContext.insert(raffle)
        path = [raffle]
        showCreateRaffle = false
    }
    
    
}

#Preview {
    ContentView()
        .modelContainer(for: Raffle.self)
}
