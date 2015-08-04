//
//  InterfaceController.swift
//  Stack WatchKit Extension
//
//  Created by Hans Knöchel on 28.07.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import WatchKit
import Foundation
import CoreData

class StackListInterfaceController: WKInterfaceController {

    @IBOutlet weak var tableView: WKInterfaceTable!
    var stacks: [String] = []
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    func loadTableData() {
        
        let dictionary = ["Models":"Stack"]

        WKInterfaceController.openParentApplication(dictionary) { (replyInfo, error) -> Void in
            
            if error != nil {
                println(error)
            }
            
            if let castedResponseDictionary = replyInfo as? [String: [String]] {
                
                self.stacks = castedResponseDictionary["Models"]!                
                self.tableView.setNumberOfRows(self.stacks.count, withRowType: "StackCell")
                
                for(index,name) in enumerate(self.stacks) {
                    var row = self.tableView.rowControllerAtIndex(index) as? StackRowTableViewController
                    row?.headlineLabel.setText(name)
                }
                
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        loadTableData()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
