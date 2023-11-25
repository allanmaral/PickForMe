//
//  RaffleCreationView.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

struct RaffleCreationView: View {
    @State private var title: String = ""
    
    var onCreate: (_ title: String) -> Void
    
    var body: some View {
        Form {
            TextField("Name", text: $title)
            Button("Create", action: create)
        }
        .navigationTitle("Novo sorteio")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func create() {
        onCreate(title)
    }
}

#Preview {
    RaffleCreationView(onCreate: { _ in })
}
