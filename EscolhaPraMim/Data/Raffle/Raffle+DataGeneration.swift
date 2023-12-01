//
//  Raffle+DataGeneration.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 30/11/23.
//

import SwiftData

extension Raffle {
    static func generateAll(modelContext: ModelContext) {
        let raffle1 = Raffle(
            "O que assistir?",
            options: [
                RaffleOption(content: "Jurassic Park", order: 1),
                RaffleOption(content: "Star Wars", flipped: true, order: 2),
                RaffleOption(content: "Blade Runner", flipped: true, order: 3),
                RaffleOption(content: "Terminator", order: 4)
            ]
        )
        modelContext.insert(raffle1)
    }
}

