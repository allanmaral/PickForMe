//
//  Pick.swift
//  PickForMe
//
//  Created by Allan Amaral on 22/11/23.
//

import Foundation
import SwiftData

@Model
final class Pick {
    var title: String
    var updatedAt: Date

    @Relationship(deleteRule: .cascade)
    var options: [PickOption]
    
    init(_ title: String = "", options: [PickOption] = [], updatedAt: Date = .now) {
        self.title = title
        self.options = options
        self.updatedAt = updatedAt
    }
    
    func set(title: String) {
        self.title = title
        updatedAt = .now
    }
    
    func shuffle() {
        var order = 0
        for optionIndex in options.indices.shuffled() {
            options[optionIndex].order = order
            options[optionIndex].flipped = true
            order += 1
        }
    }
    
    func add(option: String) {
        let option = PickOption(content: option, order: options.count)
        options.append(option)
        updatedAt = .now
    }
    
    func remove(_ option: PickOption) {
        options = options.filter { $0.id != option.id }
        normalizeIndices()
    }
    
    func pickOption() {
        let chosenIndex = options.indices.randomElement()
        for optionIndex in options.indices {
            options[optionIndex].flipped = optionIndex != chosenIndex
        }
        updatedAt = .now
    }
    
    private func normalizeIndices() {
        for optionIndex in options.indices {
            options[optionIndex].order = optionIndex
        }
    }
}
