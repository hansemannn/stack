//
//  Stack.swift
//  Stack
//
//  Created by Hans Knöchel on 13.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation

class Stack: Printable {
    
    var name: String
    var cards: [Card]
    
    init(name: String, cards: [Card]){
        self.name = name
        self.cards = cards
    }
    
    var description: String {
        return "\(self.name) hat \(self.cards) Karten"
    }
}