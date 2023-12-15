//
//  PickDetailViewModel.swift
//  PickForMe
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
    
    var focusNewOption: Bool = false
    var newOptionContent: String = ""
    var deleting: Bool = false
    
    init(pick: Pick) {
        self.pick = pick
    }
    
    var title: String {
        pick.title
    }
    
    var options: [PickOption] {
        pick.options.sorted(by: { $0.order < $1.order })
    }
    
    var shouldShowPickButton: Bool {
        pick.options.count >= 2
    }
    
    // MARK: - Intents
    
    func startDeleting() {
        deleting = true
    }
    
    func stopEditing() {
        focusNewOption = false
        deleting = false
    }
    
    func flip(_ option: PickOption) {
        stopEditing()
        option.flip()
    }
    
    func remove(_ option: PickOption) {
        pick.remove(option)
    }
    
    func addOption() {
        guard newOptionContent.isEmpty == false else { return }
        
        pick.add(option: newOptionContent)
        newOptionContent = ""
    }
    
    func shuffle() {
        stopEditing()
        pick.shuffle()
    }
    
    func debounce(after delay: TimeInterval, callback: @escaping () -> Void) {
        pickTimer?.invalidate()
        pickTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            callback()
        }
    }
    
    func pickOption() {
        pick.pickOption()
    }
}
