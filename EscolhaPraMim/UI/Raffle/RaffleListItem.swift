//
//  RaffleListItem.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 01/12/23.
//

import SwiftUI

struct RaffleListItem: View {
    let raffle: Raffle
    
    init(_ raffle: Raffle) {
        self.raffle = raffle
    }
    
    var body: some View {
        NavigationLink(value: raffle) {
            VStack(alignment: .leading) {
                Text(raffle.title)
                    .font(.headline)
                
                Text(raffle.updatedAt.formatted(.relative(presentation: .named)))
                    .font(.callout)
            }
        }
    }
}

#Preview {
    ModelPreview { raffle in
        NavigationStack {
            List {
                RaffleListItem(raffle)
            }
        }
    }
}
