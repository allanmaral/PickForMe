//
//  PickDetailView.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

struct PickDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var pick: Pick
    
    @State private var newOptionContent = ""
    @FocusState private var isNewOptionFocused
    @State private var pickTimer: Timer?
    
    var body: some View {
        ZStack {
            Color.formBackground.ignoresSafeArea()
            ScrollView {
                newOptionInput.padding()
                optionsGrid.padding()
            }
        }
        .onTapGesture(perform: endEditing)
        .overlay(alignment: .bottom, content: { chooseForMeButton })
        .navigationTitle(pick.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Shuffle", systemImage: "shuffle", action: shuffle)
        }
    }
    
    var newOptionInput: some View {
        HStack {
            TextField("Nova opção", text: $newOptionContent)
                .submitLabel(.done)
                .focused($isNewOptionFocused)
                .onSubmit(addOption)
            
            Button("Adicionar", action: addOption)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.inputBackground))
    }
    
    var optionsGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
            ForEach(pick.options.sorted(by: { $0.order < $1.order })) { option in
                CardView(card: Card(content: option.content, flipped: deletingAnimationState != .notAppeared ? false : option.flipped))
                    .aspectRatio(5/6, contentMode: .fit)
                    .overlay(alignment: .topLeading, content: {
                        if deletingAnimationState != .notAppeared {
                            Image(systemName: "minus")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.black)
                                .frame(width: 32, height: 32)
                                .background(Circle().fill(.gray))
                                .transition(.scale(scale: 0.0, anchor: UnitPoint(x: 0.1, y: 0.1)))
                                .frame(width: 44, height: 44)
                                .offset(x: -16, y: -16)
                                .onTapGesture {
                                    remove(option)
                                }
                        }
                    })
                    .shake(isShaking: deletingAnimationState == .shaking)
                    .onTapGesture { flip(option) }
                    .onLongPressGesture(perform: enterDeletionMode)
                
            }
        })
        .foregroundStyle(Gradient.backgroundCard)
    }
    
    @ViewBuilder
    var chooseForMeButton: some View {
        if pick.options.count >= 2 {
            Button("Escolha para mim!", action: pickOption)
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8)
                .padding()
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        }
    }
    
    func endEditing() {
        isNewOptionFocused = false
        deletingAnimationState = .notAppeared
    }
    
    func flip(_ option: PickOption) {
        endEditing()
        withAnimation {
            option.flipped.toggle()
        }
    }
    
    func remove(_ option: PickOption) {
        withAnimation {
            pick.options = pick.options.filter { $0.id != option.id }
        }
    }
    
    func addOption() {
        guard newOptionContent.isEmpty == false else { return }
        
        withAnimation {
            let option = PickOption(content: newOptionContent, order: pick.options.count)
            pick.options.append(option)
            pick.updatedAt = .now
            newOptionContent = ""
        }
    }
    
    func shuffle() {
        endEditing()
        
        withAnimation {
            var order = 0
            for optionIndex in pick.options.indices.shuffled() {
                pick.options[optionIndex].order = order
                pick.options[optionIndex].flipped = true
                order += 1
            }
        }
    }
    
    func pickOption() {
        endEditing()
        
        var delay: TimeInterval = 0
        for _ in 0..<5 {
            withAnimation(.linear(duration: 0.3).delay(delay)) {
                var order = 0
                for optionIndex in pick.options.indices.shuffled() {
                    pick.options[optionIndex].flipped = true
                    pick.options[optionIndex].order = order
                    order += 1
                }
            }
            delay += 0.25
        }
        
        pickTimer?.invalidate()
        pickTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
            withAnimation {
                let chosenIndex = pick.options.indices.randomElement()
                for optionIndex in pick.options.indices {
                    pick.options[optionIndex].flipped = optionIndex != chosenIndex
                }
                pick.updatedAt = .now
            }
        }
    }
    
    enum DeletingAnimationState {
        case notAppeared, appeared, shaking
    }
    
    @State var deletingAnimationState: DeletingAnimationState = .notAppeared
    
    func enterDeletionMode() {
        let delay = 0.3
        withAnimation(.easeInOut(duration: delay)) {
            deletingAnimationState = .appeared
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation (.easeInOut.repeatForever()) {
                deletingAnimationState = .shaking
            }
        }
    }
    
}

#Preview {
    ModelPreview { pick in
        PickDetailView(pick: pick)
    }
}
