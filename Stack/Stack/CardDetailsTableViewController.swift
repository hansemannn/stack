//
//  CardDetailsTableViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 14.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class CardDetailsTableViewController: UITableViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBOutlet weak var questionField: UITextView!
    @IBOutlet weak var answerField: UITextView!

    var cardData: Card!
   
    @IBAction func closeView(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deleteCard(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Karte löschen", message: "Möchtest du die Karte wirklich löschen?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Unwiderruflich löschen", style: UIAlertActionStyle.Destructive, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveCard() {
        
        var card: Card = PersistenceManager.sharedManager.createCard()
        card.question = questionField.text
        card.answer = answerField.text
                
        self.cardData = card
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.saveCard()
    }
    
    override func viewDidLoad() {
        self.submitButton.layer.cornerRadius = 5.0
    }
}
