//
//  MainMenuInterfaceController.swift
//  Stack
//
//  Created by Hans Knöchel on 04.08.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import WatchKit
import Foundation


class MainMenuInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var tableView: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
        
        self.tableView.setNumberOfRows(1, withRowType: "MenuCell")
        
        self.tableView.rowControllerAtIndex(0)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
