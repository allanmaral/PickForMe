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
    
    var body: some View {
        List {
            ForEach(raffles) { raffle in
                RaffleListItem(raffle)
            }
            .onDelete(perform: deleteRaffles)
        }
    }
    
    init(searchString: String, sort: SortDescriptor<Raffle>) {
        _raffles = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.title.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    func deleteRaffles(_ indexSet: IndexSet) {
        for index in indexSet {
            let raffle = raffles[index]
            modelContext.delete(raffle)
        }
    }
}

#Preview {
    NavigationStack {
        RaffleListingView(searchString: "", sort: SortDescriptor(\Raffle.title))
    }
    .mockRaffleDataContainer()
}
