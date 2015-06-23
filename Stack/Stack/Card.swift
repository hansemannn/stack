//
//  Card.swift
//  Stack
//
//  Created by Hans Knöchel on 13.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation
import CoreData

class Card: NSManagedObject {
    @NSManaged var question: String
    @NSManaged var answer: String
}