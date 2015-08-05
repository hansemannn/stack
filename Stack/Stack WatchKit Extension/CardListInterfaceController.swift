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
    
    var cards: [String] = []
    
    var stackName: String!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.stackName = context as? String
    }
    
    func loadTableData() {
        
        let dictionary = ["Models":"Cards", "StackName": self.stackName!] // TODO: Append stack name here
        
        WKInterfaceController.openParentApplication(dictionary) { (replyInfo, error) -> Void in
            
            if error != nil {
                println(error)
            }
            
            if let castedResponseDictionary = replyInfo as? [String: [String]] {
                
                self.cards = castedResponseDictionary["Models"]!
                self.tableView.setNumberOfRows(self.cards.count == 0 ? 1 : self.cards.count, withRowType: "CardCell")
                
                if(self.cards.count == 0) {
                    self.tableView.setHidden(true)
                    self.emptyCardLabel.setHidden(false)
                } else {
                    for(index,name) in enumerate(self.cards) {
                        var row = self.tableView.rowControllerAtIndex(index) as? CardRowTableViewController
                        row?.headlineLabel.setText(name)
                    }
                }
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.loadTableData()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
