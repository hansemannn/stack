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
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "\(stack.name) (\(self.stack.cards.count) Karten)"
        
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
        if cardsLeft == 0 {
            
            var completedCards = 0
            var canceledCards = 0
            
            for(var i = 0; i < self.stack.cards.count; i++) {
                let currentCard: Card = self.stack.cards.allObjects[i] as! Card
                if currentCard.completed == true {
                    completedCards++
                } else {
                    canceledCards++
                }
            }
            
            var alert = UIAlertController(
                title: "Übung abgeschlossen",
                message: "Die Übung \"\(self.stack.name)\" ist abgeschlossen.\n\nErgebnis: \(completedCards) gewusst, \(canceledCards) abgebrochen",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
