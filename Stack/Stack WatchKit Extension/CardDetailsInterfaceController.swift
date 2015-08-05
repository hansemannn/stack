//
//  CardDetailsInterfaceController.swift
//  Stack
//
//  Created by Hans Knöchel on 28.07.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import WatchKit

class CardDetailsInterfaceController: WKInterfaceController {
    
    // TODO: Rethink data structure here
    var card: [String]!
    
    @IBOutlet weak var questionLabel: WKInterfaceLabel!

    @IBOutlet weak var answerLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.card = context as? [String]
        self.questionLabel.setText(self.card[0])
        self.answerLabel.setText(self.card[1])
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    @IBAction func onLeftButtonPressed() {
        println("NO")
    }
    
    @IBAction func onRightButtonPressed() {
        println("YES")
    }
}
