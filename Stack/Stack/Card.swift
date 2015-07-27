//
//  Card.swift
//  Stack
//
//  Created by Jan Vennemann on 27/07/15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation
import CoreData

@objc(Card)
class Card: NSManagedObject {

    @NSManaged var answer: String
    @NSManaged var category_id: NSNumber
    @NSManaged var question: String
    @NSManaged var stack: Stack

}
