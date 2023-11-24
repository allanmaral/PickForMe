//
//  EditRaffleView.swift
//  SelectMate
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

struct EditRaffleView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var raffle: Raffle
    @State private var newOptionContent = ""
    
//    var modelContext: ModelContext
    
//    init(raffleID: PersistentIdentifier, in container: ModelContainer) {
//        modelContext = ModelContext(container)
//        modelContext.autosaveEnabled = false
//        raffle = modelContext.model(for: raffleID) as? Raffle ?? Raffle()
//    }
    
    let options = [
        "Jurassic Park",
        "Sei lá",
        "The Office",
        "Community"
    ]
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        TextField("Nova opção", text: $newOptionContent)
                        
                        Button("Adicionar", action: addOption)
                    }
                }
                
                LazyVGrid(columns: [GridItem(), GridItem()], content: {
                    ForEach(raffle.options.sorted(by: { $0.order < $1.order })) { option in
                        CardView(card: Card(content: option.content, flipped: option.flipped))
                            .aspectRatio(3/2, contentMode: .fit)
                            .onTapGesture {
                                withAnimation {
                                    option.flipped.toggle()
                                }
                            }
                    }
                })
                .foregroundColor(.orange)
                
            }
        }
        .overlay(alignment: .bottom, content: {
            if raffle.options.count >= 2 {
                Button("Escolha para mim!", action: raffleOption)
                    .foregroundColor(.white)
                    .padding()
                    .background(.orange)
                    .cornerRadius(8)
                    .shadow(radius: 16, x: 0, y: 4)
            }
        })
        .navigationTitle(raffle.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Shuffle", systemImage: "shuffle", action: shuffle)
        }
    }
    
    func addOption() {
        guard newOptionContent.isEmpty == false else { return }
        
        withAnimation {
            let option = Option(content: newOptionContent, order: raffle.options.count)
            raffle.options.append(option)
            newOptionContent = ""
        }
    }
    
    func shuffle() {
        withAnimation {
            var order = 0
            for optionIndex in raffle.options.indices.shuffled() {
                raffle.options[optionIndex].order = order
                raffle.options[optionIndex].flipped = true
                order += 1
            }
        }
    }
    
    func raffleOption() {
        var delay: TimeInterval = 0
        for _ in 0..<5 {
            withAnimation(.linear(duration: 0.3).delay(delay)) {
                var order = 0
                for optionIndex in raffle.options.indices.shuffled() {
                    raffle.options[optionIndex].flipped = true
                    raffle.options[optionIndex].order = order
                    order += 1
                }
            }
            delay += 0.25
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(1500))) {
            withAnimation {
                let chosenIndex = raffle.options.indices.randomElement()
                if let chosenIndex {
                    raffle.options[chosenIndex].flipped = false
                }
            }
        }
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Raffle.self, configurations: configuration)
        let modelContext = ModelContext(container)
        let raffle = Raffle()
        modelContext.insert(raffle)
        return EditRaffleView(raffle: raffle)
    } catch {
        fatalError("Failed to create model container.")
    }
}
