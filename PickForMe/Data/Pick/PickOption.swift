//
//  PickOption.swift
//  PickForMe
//
//  Created by Allan Amaral on 22/11/23.
//

import Foundation
import SwiftData

@Model
final class PickOption {
    var content: String
    var flipped: Bool
    var order: Int
    
    init(content: String = "", flipped: Bool = false, order: Int = 0) {
        self.content = content
        self.flipped = flipped
        self.order = order
    }
    
    func flip() {
        flipped.toggle()
    }
}
