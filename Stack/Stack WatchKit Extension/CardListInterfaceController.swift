//
//  CardListInterfaceController.swift
//  Stack
//
//  Created by Hans Knöchel on 28.07.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import WatchKit
import Foundation

class CardListInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var emptyCardLabel: WKInterfaceLabel!
    
    @IBOutlet weak var tableView: WKInterfaceTable!
    
    var cards: NSMutableDictionary!
    
    var stackName: String!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.stackName = context as? String
    }
    
    /**
    Loads all cards by calling the parent application.
    
    :returns: void
    */
    func loadTableData() {
        
        let dictionary = ["Models":"Cards", "StackName": self.stackName!] // TODO: Append stack name here
        
        WKInterfaceController.openParentApplication(dictionary) { (replyInfo, error) -> Void in
            
            if error != nil {
                println(error)
            }
            
            if let castedResponseDictionary = replyInfo["Models"] as? [String : String] {
                
                self.cards = NSMutableDictionary(dictionary: castedResponseDictionary)
                self.tableView.setNumberOfRows(self.cards.count == 0 ? 1 : self.cards.count, withRowType: "CardCell")
                
                if self.cards.count == 0 {
                    self.tableView.setHidden(true)
                    self.emptyCardLabel.setHidden(false)
                } else {
                    for(index, name) in enumerate(self.cards) {
                        var row = self.tableView.rowControllerAtIndex(index) as? CardRowTableViewController
                        row?.question = name.key as? String
                        row?.answer = name.value as? String
                        row?.headlineLabel.setText(name.key as? String)
                    }
                }
            }
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        if segueIdentifier == "OpenCardDetailsSegue" {
            return [self.cards.allKeys[rowIndex], self.cards.allValues[rowIndex]]
        }
        
        return nil
    }
    
    override func willActivate() {
        super.willActivate()

        self.loadTableData()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
}
