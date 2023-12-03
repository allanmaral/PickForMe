//
//  DataGeneration.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 30/11/23.
//

import SwiftData

public struct DataGeneration {
    public static func generateAllData(modelContext: ModelContext) {
        Pick.generateAll(modelContext: modelContext)
    }
}
