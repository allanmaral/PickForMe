//
//  PickDetailViewModel.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 07/12/23.
//

import Foundation
import Observation
import SwiftData

@Observable
final class PickDetailViewModel {
    private(set) var pick: Pick
    private var pickTimer: Timer?
    private var delete = DeletionViewModel()
    
    var focusNewOption: Bool = false
    var newOptionContent: String = ""
    
    init(pick: Pick) {
        self.pick = pick
    }
    
    var title: String {
        pick.title
    }
    
    var options: [PickOption] {
        pick.options.sorted(by: { $0.order < $1.order })
    }
    
    var deleting: Bool {
        delete.deleting
    }
    
    var shaking: Bool {
        delete.shouldShake
    }
    
    var shouldShowPickButton: Bool {
        pick.options.count >= 2
    }
    
    // MARK: - Intents
    
    func startDeleting() {
        delete.enterDeletionMode()
    }
    
    func stopDeleting() {
        delete.leaveDeletionMode()
    }
    
    func stopEditing() {
        focusNewOption = false
        delete.leaveDeletionMode()
    }
    
    func flip(_ option: PickOption) {
        stopEditing()
        option.flipped.toggle()
    }
    
    func remove(_ option: PickOption) {
        pick.options = pick.options.filter { $0.id != option.id }
    }
    
    func addOption() {
        guard newOptionContent.isEmpty == false else { return }
        
        let option = PickOption(content: newOptionContent, order: pick.options.count)
        pick.options.append(option)
        pick.updatedAt = .now
        newOptionContent = ""
    }
    
    func shuffle() {
        stopEditing()
        
        var order = 0
        for optionIndex in pick.options.indices.shuffled() {
            pick.options[optionIndex].order = order
            pick.options[optionIndex].flipped = true
            order += 1
        }
    }
    
    func debounce(after delay: TimeInterval, callback: @escaping () -> Void) {
        pickTimer?.invalidate()
        pickTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            callback()
        }
    }
    
    func pickOption() {
        let chosenIndex = pick.options.indices.randomElement()
        for optionIndex in pick.options.indices {
            pick.options[optionIndex].flipped = optionIndex != chosenIndex
        }
        pick.updatedAt = .now
    }
}
