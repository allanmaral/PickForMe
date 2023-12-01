//
//  RaffleMockDataContainer.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 30/11/23.
//

import SwiftData
import SwiftUI

struct GenerateDataViewModifier: ViewModifier {
    @Environment(\.modelContext) private var modelContext
    
    func body(content: Content) -> some View {
        content.onAppear {
            DataGeneration.generateAllData(modelContext: modelContext)
        }
    }
}

public extension View {
    fileprivate func mockData() -> some View {
        modifier(GenerateDataViewModifier())
    }
    
    func mockRaffleDataContainer() -> some View {
        self
            .mockData()
            .raffleDataContainer(inMemory: true)
    }
}
