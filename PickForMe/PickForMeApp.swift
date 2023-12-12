//
//  PickForMeApp.swift
//  PickForMe
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

@main
struct PickForMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .pickDataContainer(inMemory: false)
        }
    }
}
