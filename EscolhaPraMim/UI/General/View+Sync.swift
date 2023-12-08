//
//  View+Sync.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 07/12/23.
//

import SwiftUI

extension View {
    func sync<T: Equatable>(_ binding: Binding<T>, with focusState: FocusState<T>) -> some View {
        self
            .onAppear { focusState.wrappedValue = binding.wrappedValue }
            .onChange(of: binding.wrappedValue) { _, value in focusState.wrappedValue = value }
            .onChange(of: focusState.wrappedValue) { _, value in binding.wrappedValue = value }
    }
}
