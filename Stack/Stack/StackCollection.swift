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
        let newStack = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //Set values of the managed object
        newStack.setValue(stack.name, forKey: "name")
        
        //Save managed context
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        } else {
            println("\(stack.name) wurde erfolgreich gespeichert!")
            return true
        }

        return false
    }
    
    func getStacks() -> [Stack]? {
        //  Get managed context of the app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //Create fetch request to get all entries of the profile table
        let fetchRequest = NSFetchRequest(entityName: "Stack")
        
        //  Execute fetch request
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        //If results not nil, create array of profiles, else return nil
        if let results = fetchedResults {
            var stacks = [Stack]()
            for result in results {
                var stack = Stack(name: (result.valueForKey("name") as? String)!, cards:[Card(question: "", answer: "")])
                stacks.append(stack)
            }
            
            return stacks
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
            return nil
        }
    }
}

