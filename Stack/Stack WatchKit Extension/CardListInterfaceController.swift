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
    
    @IBOutlet weak var tableView: WKInterfaceTable!
    let cards = ["Frage 1", "Frage 2"]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    func loadTableData() {
        
        self.tableView.setNumberOfRows(cards.count, withRowType: "CardCell")
        
        for(index,name) in enumerate(cards) {
            var row = self.tableView.rowControllerAtIndex(index) as? CardRowTableViewController
            row?.headlineLabel.setText(name)
        }
    }
    
    override func willActivate() {
        loadTableData()
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
