//
//  SwipeStackViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 27.07.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class SwipeStackViewController: UIViewController, EmptyStackDelegate {

    var stack: String!
    var cards: [String]!

    @IBAction func closeView(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stack = "Mathe"
        self.cards = ["Test1", "Test2"]
        
        self.navigationController?.navigationBar.topItem?.title = "\(stack) (\(count(cards)) Karten)"
        
        var draggableBackground: DraggableViewBackground = DraggableViewBackground(frame: self.view.frame)
        draggableBackground.delegate = self
        draggableBackground.cards = cards
        draggableBackground.loadCards()
        
        self.view.addSubview(draggableBackground)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func stackChanged(cardsLeft: Int) {
        if(cardsLeft == 0) {
            var alert = UIAlertController(
                title: "Stapel abgeschlossen",
                message: "\"\(self.stack)\" wurde abgeschlossen!",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
