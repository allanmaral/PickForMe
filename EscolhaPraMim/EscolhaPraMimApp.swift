//
//  EscolhaPraMimApp.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

@main
struct EscolhaPraMimApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .pickDataContainer(inMemory: false)
        }
    }
}
