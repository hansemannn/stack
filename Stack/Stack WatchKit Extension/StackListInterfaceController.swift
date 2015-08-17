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
    
    @IBOutlet weak var emptyStackLabel: WKInterfaceLabel!

    @IBOutlet weak var tableView: WKInterfaceTable!
    
    var stacks: [String] = []
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    /**
    Loads all stacks by calling the parent application.
    
    :returns: void
    */
    func loadTableData() -> Void {
        
        let dictionary = ["Models":"Stacks"]

        WKInterfaceController.openParentApplication(dictionary) { (replyInfo, error) -> Void in
            
            if error != nil {
                println(error)
            }
            
            if let castedResponseDictionary = replyInfo as? [String: [AnyObject]] {
                
                let cardsCount: [Int] = castedResponseDictionary["CardCount"] as! [Int]!
                self.stacks = castedResponseDictionary["Models"] as! [String]!

                self.tableView.setNumberOfRows(self.stacks.count == 0 ? 1 : self.stacks.count, withRowType: "StackCell")
                
                if self.stacks.count == 0 {
                    self.tableView.setHidden(true)
                    self.emptyStackLabel.setHidden(false)
                } else {
                    for(index,name) in enumerate(self.stacks) {
                        var row = self.tableView.rowControllerAtIndex(index) as? StackRowTableViewController
                        row?.stackName = name
                        row?.numberOfStacks = cardsCount[index]
                        row?.numberLabel.setText(String(cardsCount[index]))
                        row?.headlineLabel.setText(name)
                    }
                }
            }
        }
    }
    
    override func willActivate() {
        super.willActivate()
        
        self.loadTableData()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        if segueIdentifier == "OpenCardListSegue" {
            return self.stacks[rowIndex]
        }
        
        return nil
    }
}
