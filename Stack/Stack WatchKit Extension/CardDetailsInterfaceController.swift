//
//  CardDetailsInterfaceController.swift
//  Stack
//
//  Created by Hans Knöchel on 28.07.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import WatchKit

class CardDetailsInterfaceController: WKInterfaceController {
    @IBOutlet weak var questionLabel: WKInterfaceLabel!

    @IBOutlet weak var answerLabel: WKInterfaceLabel!

    @IBAction func onLeftButtonPressed() {
        println("NO")
    }
    
    @IBAction func onRightButtonPressed() {
        println("YES")
    }
}
