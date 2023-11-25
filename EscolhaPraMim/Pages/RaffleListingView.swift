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
                NavigationLink(value: raffle) {
                    VStack(alignment: .leading) {
                        Text(raffle.title)
                            .font(.headline)
                        
                        Text(raffle.createdAt.formatted(.relative(presentation: .named)))
                            .font(.callout)
                    }
                }
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
    RaffleListingView(searchString: "", sort: SortDescriptor(\Raffle.title))
        .modelContainer(for: Raffle.self)
}
