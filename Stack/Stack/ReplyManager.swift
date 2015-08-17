//
//  ReplyManager.swift
//  Stack
//
//  Created by Hans Knöchel on 12.08.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation

class ReplyManager {
    
    var requestedModels: [String : String]
    var reply: (([NSObject : AnyObject]!) -> Void)!
    
    init(userInfo: [String : String], reply: (([NSObject : AnyObject]!) -> Void)!) {
        self.requestedModels = userInfo
        self.reply = reply
    }
    
    /**
    Handle a watchkit extension request.
    
    :returns: void
    */
    func handleWatchKitExtensionRequest() {       
        if self.requestedModels["Models"] == "Stacks" {
            self.getAllStacks()
        } else if self.requestedModels["Models"] == "Cards" {
            self.getCardsByStack()
        }
    }
    
    /**
    Gets all cards depending on the stack name given by the WatchKit application.
    
    :returns: void
    */
    func getCardsByStack() -> Void {
        let stackName = requestedModels["StackName"]!
        let cards: [Card] = PersistenceManager.sharedManager.findCardsByStackName(stackName)
        
        if cards.count == 0 {
            self.reply(["Models" : NSDictionary()])
            return;
        }
        
        var cardsAsDictionary = NSMutableDictionary(capacity: cards.count)
        
        for(var i = 0; i < cards.count; i++) {
            cardsAsDictionary.setObject(cards[i].answer, forKey: cards[i].question)
        }
        
        self.reply(["Models" : cardsAsDictionary])
    }
    
    /**
    Gets all stacks depending on the stack name given by the WatchKit application.
    
    :returns: void
    */
    func getAllStacks() -> Void {
        var stacks: [Stack] = PersistenceManager.sharedManager.findAllStacks()
        
        if stacks.count == 0 {
            self.reply(["Models" : []])
            return;
        }
        
        var stacksAsStringArray = [String]()
        var countsArray = [Int]()
        
        for(var i = 0; i < stacks.count; i++) {
            stacksAsStringArray.append(stacks[i].name)
            countsArray.append(stacks[i].cards.allObjects.count)
        }
        
        self.reply(["Models" : stacksAsStringArray, "CardCount" : countsArray])
    }
}