//
//  Stack.swift
//  Stack
//
//  Created by Jan Vennemann on 27/07/15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation
import CoreData

@objc(Stack)
class Stack: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var cards: NSSet
    
    func addCard(card: Card) {
        self.mutableSetValueForKey("cards").addObject(card)
    }
    
    func removeCard(card: Card) {
        self.mutableSetValueForKey("cards").removeObject(card)
    }

}
