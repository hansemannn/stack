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

class StackCollection : NSObject {
    var amount: Double = 0.0
    var duration: Int = 1
    var interest: Double = 0.0
    var lastResult: Double?
    static let instance = StackCollection()
    
    func saveStack(stack: Stack) -> Bool {
        //Get managed context of the app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //Create a empty managed object with a profile entity description in our managed context
        let entity = NSEntityDescription.entityForName("Stack", inManagedObjectContext: managedContext)
        let newStack = NSEntityDescription.insertNewObjectForEntityForName("Stack", inManagedObjectContext: managedContext) as! Stack
        
        newStack.name = stack.name
        newStack.cards = stack.cards
        
        //Save managed context
        var error: NSErrorPointer = NSErrorPointer()
        managedContext.save(error)
        
        return false
    }
    
    func getStacks() -> [Stack]? {
        //  Get managed context of the app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //Create fetch request to get all entries of the profile table
        let fetchRequest = NSFetchRequest(entityName: "Stack")
        let error: NSErrorPointer = NSErrorPointer()
                
        // Execute the fetch request, and cast the results to an array of LogItem objects
        if let fetchResults = managedContext.executeFetchRequest(fetchRequest, error: error) as? [Stack] {
            print(fetchResults)
            return fetchResults
        } else {
            print("Could not fetch \(error), \(error.debugDescription)")
            return nil
        }
    }
}

