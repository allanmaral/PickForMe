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
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
                    ForEach(raffle.options) { option in
                        let shape = RoundedRectangle(cornerRadius: 12)
                        let text = Text(option.content)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.black)
                        
                        ZStack {
                            Group {
                                shape.fill(.white)
                                shape.strokeBorder(lineWidth: 2)
                                text
                            }
                            .opacity(option.flipped ? 0 : 1)
                            
                            Group {
                                shape.fill()
                                text.opacity(0)
                            }
                            .opacity(option.flipped ? 1 : 0)
                        }
                        .aspectRatio(3/4, contentMode: .fit)
                        .onTapGesture {
                            option.flipped.toggle()
                        }
                    }
                })
                .foregroundColor(.orange)
                    
            }
        }
        .navigationTitle(raffle.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbarRole(.editor)
    }
    
    func addOption() {
        guard newOptionContent.isEmpty == false else { return }
        
        withAnimation {
            let option = Option(content: newOptionContent)
            raffle.options.append(option)
            newOptionContent = ""
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
