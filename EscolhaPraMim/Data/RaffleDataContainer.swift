//
//  RaffleDataContainer.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 30/11/23.
//

import SwiftUI
import SwiftData

struct RaffleDataContainerViewModifier: ViewModifier {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        container = try! ModelContainer(
            for: Schema([Raffle.self]),
            configurations: [ModelConfiguration(isStoredInMemoryOnly: inMemory)]
        )
    }
    
    func body(content: Content) -> some View {
        content.modelContainer(container)
    }
}

public extension View {
    func raffleDataContainer(inMemory: Bool = DataGenerationOptions.inMemoryPersistence) -> some View {
        modifier(RaffleDataContainerViewModifier(inMemory: inMemory))
    }
}

