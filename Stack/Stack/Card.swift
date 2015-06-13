//
//  Card.swift
//  Stack
//
//  Created by Hans Knöchel on 13.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation

class Card: Printable {
    
    var question: String
    var answer: String
    
    init(question: String, answer: String){
        self.question = question
        self.answer = answer
    }
    
    var description: String {
        return "\(self.question): \(self.answer)"
    }
}