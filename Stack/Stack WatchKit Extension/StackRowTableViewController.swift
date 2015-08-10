//
//  StackRowTableViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 28.07.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import WatchKit

class StackRowTableViewController: NSObject {
    
    var stackName: String!
    var numberOfStacks: Int = 0
    
    @IBOutlet weak var numberLabel: WKInterfaceLabel!
    
    @IBOutlet weak var headlineLabel: WKInterfaceLabel!
}
