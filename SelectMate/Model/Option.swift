//
//  Option.swift
//  SelectMate
//
//  Created by Allan Amaral on 22/11/23.
//

import Foundation
import SwiftData

@Model
class Option {
    var content: String
    var flipped: Bool
    
    init(content: String = "", flipped: Bool = false) {
        self.content = content
        self.flipped = flipped
    }
}
