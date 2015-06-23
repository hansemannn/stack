//
//  Stack.swift
//  Stack
//
//  Created by Hans Knöchel on 13.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation
import CoreData

class Stack: NSManagedObject {    
    @NSManaged var name: String
    @NSManaged var cards: [Card]
}