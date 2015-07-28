//
//  InterfaceController.swift
//  Stack WatchKit Extension
//
//  Created by Hans Knöchel on 28.07.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import WatchKit
import Foundation

class StackListInterfaceController: WKInterfaceController {

    @IBOutlet weak var tableView: WKInterfaceTable!
    let stacks = ["Mathe", "Physik"]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    func loadTableData() {
        
        self.tableView.setNumberOfRows(stacks.count, withRowType: "StackCell")
        
        for(index,name) in enumerate(stacks) {
            println(name)
            var row = self.tableView.rowControllerAtIndex(index) as? StackRowTableViewController
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
