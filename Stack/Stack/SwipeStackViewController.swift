//
//  SwipeStackViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 27.07.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class SwipeStackViewController: UIViewController, EmptyStackDelegate {

    var stack: Stack!

    @IBAction func closeView(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cards = self.stack.cards
        
        self.navigationController?.navigationBar.topItem?.title = "\(stack.name) (\(cards.count) Karten)"
        
        var draggableBackground: DraggableViewBackground = DraggableViewBackground(frame: self.view.frame)
        draggableBackground.delegate = self
        draggableBackground.cards = self.stack.cards.allObjects as? [Card]
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
                message: "\"\(self.stack.name)\" wurde abgeschlossen!",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
