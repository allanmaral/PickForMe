//
//  PickDataContainer.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 30/11/23.
//

import SwiftUI
import SwiftData

struct PickDataContainerViewModifier: ViewModifier {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        container = try! ModelContainer(
            for: Schema([Pick.self]),
            configurations: [ModelConfiguration(isStoredInMemoryOnly: inMemory)]
        )
    }
    
    func body(content: Content) -> some View {
        content.modelContainer(container)
    }
}

public extension View {
    func pickDataContainer(inMemory: Bool = DataGenerationOptions.inMemoryPersistence) -> some View {
        modifier(PickDataContainerViewModifier(inMemory: inMemory))
    }
}

