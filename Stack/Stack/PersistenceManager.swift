//
//  Stack.swift
//  Zinsrechner
//
//  Created by Hans Knöchel on 27.04.15.
//  Copyright (c) 2015 HS Osnabrueck. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersistenceManager : NSObject {
    
    let managedObjectContext: NSManagedObjectContext
    
    class var sharedManager: PersistenceManager {
        struct Singleton {
            static let instance = PersistenceManager()
        }
        
        return Singleton.instance
    }
    
    override init() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext!
    }
    
    func createStack() -> Stack {
        let newStack = NSEntityDescription.insertNewObjectForEntityForName("Stack", inManagedObjectContext: self.managedObjectContext) as! Stack
        
        return newStack
    }
    
    func createCard() -> Card {
        let newCard = NSEntityDescription.insertNewObjectForEntityForName("Card", inManagedObjectContext: self.managedObjectContext) as! Card
        
        return newCard        
    }
    
    func findAllStacks() -> [Stack] {
        let fetchRequest = NSFetchRequest(entityName: "Stack")
        let error: NSErrorPointer = NSErrorPointer()
                
        if let fetchResults = self.managedObjectContext.executeFetchRequest(fetchRequest, error: error) as? [Stack] {
            return fetchResults
        } else {
            print("Could not fetch \(error), \(error.debugDescription)")
            return []
        }
    }
    
    func findStackByStackName(stackName: String) -> Stack! {
        let stacks = self.findAllStacks()
        
        for(var i = 0; i < stacks.count; i++) {
            if stacks[i].name == stackName {                
                return stacks[i]
            }
        }
        
        return nil
    }
    
    func findCardsByStackName(stackName: String) -> [Card] {
        let stack = self.findStackByStackName(stackName)
        
        if stack == nil {
            return []
        }
        
        return stack.cards.allObjects as! [Card]
    }
    
    func persistAll() {
        var error: NSErrorPointer = NSErrorPointer()
        if !self.managedObjectContext.save(error) {
            println("Could not save \(error), \(error.debugDescription)")
        }
    }
}

