//
//  Raffle.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 22/11/23.
//

import Foundation
import SwiftData

@Model
final class Raffle {
    var title: String
    var updatedAt: Date

    @Relationship(deleteRule: .cascade)
    var options: [RaffleOption]
    
    init(_ title: String = "", options: [RaffleOption] = [], updatedAt: Date = .now) {
        self.title = title
        self.options = options
        self.updatedAt = updatedAt
    }
}
