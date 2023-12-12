//
//  DeletionViewModel.swift
//  PickForMe
//
//  Created by Allan Amaral on 05/12/23.
//

import SwiftUI

@Observable
final class DeletionState {
    private enum DeletingAnimationState {
        case idle, starting, shaking
    }
    
    private var state = DeletingAnimationState.idle
    private var shakeTimer: Timer?
    
    var deleting: Bool {
        get { state != .idle }
        set {
            if newValue {
                startDeleting()
            } else {
                stopDeleting()
            }
        }
    }
    
    var shaking: Bool {
        state == .shaking
    }
    
    private func startDeleting() {
        let delay = 0.3
        withAnimation(.easeInOut(duration: delay)) {
            state = .starting
        }
        
        shakeTimer?.invalidate()
        shakeTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            self?.state = .shaking
        }
    }
    
    private func stopDeleting() {
        shakeTimer?.invalidate()
        withAnimation(.easeInOut) {
            state = .idle
        }
    }
}

extension View {
    func sync(_ binding: Binding<Bool>, with deletionState: DeletionState) -> some View {
        self
            .onAppear { deletionState.deleting = binding.wrappedValue }
            .onChange(of: binding.wrappedValue) { _, value in deletionState.deleting = value }
    }
}
