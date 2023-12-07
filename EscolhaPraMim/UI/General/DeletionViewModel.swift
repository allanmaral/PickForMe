//
//  DeletionViewModel.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 05/12/23.
//

import SwiftUI

final class DeletionViewModel: ObservableObject {
    private enum DeletingAnimationState {
        case idle, starting, deleting
    }
    
    @Published private var animationState = DeletingAnimationState.idle
    
    var shouldShake: Bool {
        animationState == .deleting
    }
    
    var deleting: Bool {
        animationState != .idle
    }
    
    func enterDeletionMode() {
        let delay = 0.3
        withAnimation(.easeInOut(duration: delay)) {
            animationState = .starting
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            withAnimation (.easeInOut.repeatForever()) {
                self?.animationState = .deleting
            }
        }
    }
    
    func leaveDeletionMode() {
        withAnimation(.easeInOut) {
            animationState = .idle
        }
    }
}
