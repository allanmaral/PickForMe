//
//  RaffleListingView.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

struct RaffleListingView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Raffle.title) var raffles: [Raffle]
    
    var edit: (Raffle) -> Void
    
    var body: some View {
        List {
            ForEach(raffles) { raffle in
                RaffleListItem(raffle)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            delete(raffle)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button {
                            edit(raffle)
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
            }
        }
    }
    
    init(searchString: String, sort: SortDescriptor<Raffle>, onEditRaffle: @escaping (Raffle) -> Void) {
        edit = onEditRaffle
        _raffles = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.title.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    func delete(_ raffle: Raffle) {
        modelContext.delete(raffle)
    }
}

#Preview {
    NavigationStack {
        RaffleListingView(searchString: "", sort: SortDescriptor(\Raffle.title)) { _ in }
    }
    .mockRaffleDataContainer()
}
