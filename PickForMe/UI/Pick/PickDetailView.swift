//
//  PickDetailView.swift
//  PickForMe
//
//  Created by Allan Amaral on 22/11/23.
//

import SwiftData
import SwiftUI

struct PickDetailView: View {
    @Bindable var viewModel: PickDetailViewModel
    @Bindable private var deletionState = DeletionState()
    @Environment(\.dismiss) var dismiss
    @FocusState private var isNewOptionFocused
    
    var body: some View {
        ZStack {
            Color.formBackground.ignoresSafeArea()
            ScrollView {
                newOptionInput.padding()
                optionsGrid.padding()
            }
        }
        .sync($viewModel.focusNewOption, with: _isNewOptionFocused)
        .sync($viewModel.deleting, with: deletionState)
        .onTapGesture {
            withAnimation(.easeInOut) {
                viewModel.stopEditing()                
            }
        }
        .overlay(alignment: .bottom, content: { chooseForMeButton })
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Shuffle", systemImage: "shuffle") {
                withAnimation { viewModel.shuffle() }
            }
        }
    }
    
    var newOptionInput: some View {
        HStack {
            TextField("New option", text: $viewModel.newOptionContent)
                .submitLabel(.done)
                .focused($isNewOptionFocused)
                .onSubmit {
                    withAnimation { viewModel.addOption() }
                }
            
            Button("Add") {
                withAnimation { viewModel.addOption() }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.inputBackground))
    }
    
    var optionsGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
            ForEach(viewModel.options) { option in
                CardView(card: Card(content: option.content, flipped: deletionState.deleting ? false : option.flipped))
                    .aspectRatio(5/6, contentMode: .fit)
                    .overlay(alignment: .topLeading, content: {
                        deleteButton(for: option)
                    })
                    .shake(isShaking: deletionState.shaking)
                    .onTapGesture {
                        withAnimation { viewModel.flip(option) }
                    }
                    .onLongPressGesture {
                        viewModel.startDeleting()
                    }
                
            }
        })
        .foregroundStyle(Gradient.backgroundCard)
    }
    
    @ViewBuilder
    var chooseForMeButton: some View {
        if viewModel.shouldShowPickButton {
            Button("Pick for me!", action: pickOption)
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8)
                .padding()
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        }
    }
    
    @ViewBuilder
    func deleteButton(for option: PickOption) -> some View {
        if deletionState.deleting {
            Image(systemName: "minus")
                .fontWeight(.bold)
                .foregroundStyle(Color.black)
                .frame(width: 32, height: 32)
                .background(Circle().fill(.gray))
                .transition(.scale(scale: 0.0, anchor: UnitPoint(x: 0.1, y: 0.1)))
                .frame(width: 44, height: 44)
                .offset(x: -16, y: -16)
                .onTapGesture {
                    withAnimation { viewModel.remove(option) }
                }
        }
    }
    
    func pickOption() {
        var delay: TimeInterval = 0
        for _ in 0..<Constants.Shuffle.count {
            withAnimation(.linear(duration: Constants.Shuffle.duration).delay(delay)) {
                viewModel.shuffle()
            }
            delay += Constants.Shuffle.delay
        }
        
        viewModel.debounce(after: Constants.Shuffle.cardRevealDelay) {
            withAnimation {
                viewModel.pickOption()
            }
        }
    }
    
    private enum Constants {
        enum Shuffle {
            static let count = 5
            static let duration: TimeInterval = 0.3
            static let delay: TimeInterval = 0.25
            static let cardRevealDelay = TimeInterval(Shuffle.count + 1) * Shuffle.delay
        }
    }
}

#Preview {
    ModelPreview { pick in
        PickDetailView(viewModel: PickDetailViewModel(pick: pick))
    }
}
