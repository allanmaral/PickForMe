//
//  SelectMateApp.swift
//  SelectMate
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

@main
struct SelectMateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Raffle.self)
    }
}
