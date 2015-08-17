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
    
    /**
    Returns a singleton instance of the class.
    
    :returns: The singleton instance.
    */
    class var sharedManager: PersistenceManager {
        struct Singleton {
            static let instance = PersistenceManager()
        }
        
        return Singleton.instance
    }
    
    /**
    Sets the managed object context of the app delegate.
    */
    override init() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext!
    }
    
    /**
    Creates a new stack.
    
    :returns: The new created stack.
    */
    func createStack() -> Stack {
        let newStack = NSEntityDescription.insertNewObjectForEntityForName("Stack", inManagedObjectContext: self.managedObjectContext) as! Stack
        
        return newStack
    }
    
    /**
    Creates a new card.
    
    :returns: The new created card.
    */
    func createCard() -> Card {
        let newCard = NSEntityDescription.insertNewObjectForEntityForName("Card", inManagedObjectContext: self.managedObjectContext) as! Card
        
        return newCard        
    }
    
    /**
    Finds all stacks.
    
    :returns: An array of all stacks if existing, an empty array if not.
    */
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
    
    /**
    Finds an stack depending on the name.
    
    :param: stackName   The name of the stack.
    
    :returns: The found stack if existing, nil if not.
    */
    func findStackByStackName(stackName: String) -> Stack! {
        let stacks = self.findAllStacks()
        
        for(var i = 0; i < stacks.count; i++) {
            if stacks[i].name == stackName {                
                return stacks[i]
            }
        }
        
        return nil
    }
    
    /**
    Finds all card of a stack depending on the name.
    
    :param: stackName   The name of the stack.
    
    :returns: An array of cards if existing, an empty array if not.
    */
    func findCardsByStackName(stackName: String) -> [Card] {
        let stack = self.findStackByStackName(stackName)
        
        if stack == nil {
            return []
        }
        
        return stack.cards.allObjects as! [Card]
    }
    
    /**
    Persists the current context
    
    :returns: void
    */
    func persistAll() -> Void {
        var error: NSErrorPointer = NSErrorPointer()
        if !self.managedObjectContext.save(error) {
            println("Could not save \(error), \(error.debugDescription)")
        }
    }
}

