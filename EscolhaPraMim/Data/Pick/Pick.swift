//
//  Pick.swift
//  EscolhaPraMim
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
}
