//
//  Item.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2024-08-29.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
