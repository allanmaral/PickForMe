//
//  Pick+DataGeneration.swift
//  PickForMe
//
//  Created by Allan Amaral on 30/11/23.
//

import SwiftData

extension Pick {
    static func generateAll(modelContext: ModelContext) {
        let pick1 = Pick(
            "O que assistir?",
            options: [
                PickOption(content: "Jurassic Park", order: 1),
                PickOption(content: "Star Wars", flipped: true, order: 2),
                PickOption(content: "Blade Runner", flipped: true, order: 3),
                PickOption(content: "Terminator", order: 4)
            ]
        )
        modelContext.insert(pick1)
    }
}

