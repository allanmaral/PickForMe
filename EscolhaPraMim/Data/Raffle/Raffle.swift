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
    var raffled: Bool
    var createdAt: Date

    @Relationship(deleteRule: .cascade)
    var options: [RaffleOption]
    
    init(_ title: String = "", raffled: Bool = false, options: [RaffleOption] = [], createdAt: Date = .now) {
        self.title = title
        self.raffled = raffled
        self.options = options
        self.createdAt = createdAt
    }
}
