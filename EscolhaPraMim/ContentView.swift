//
//  ContentView.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        RaffleNavigationStack()
    }
}

#Preview {
    ContentView()
        .mockRaffleDataContainer()
}
