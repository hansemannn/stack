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
    var isNewCard: Bool = true
   
    @IBAction func closeView(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
        
    @IBAction func deleteCard(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Karte löschen", message: "Möchtest du die Karte wirklich löschen?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Unwiderruflich löschen", style: UIAlertActionStyle.Destructive, handler: {
            (action: UIAlertAction!) in
            self.cardData.stack.removeCard(self.cardData)
            PersistenceManager.sharedManager.persistAll()
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.isNewCard = self.cardData == nil
        
        if(self.isNewCard) {
            self.navigationController?.navigationBar.topItem?.title = "Neue Karte"
            self.navigationItem.setRightBarButtonItem(UIBarButtonItem(customView: UIView(frame: CGRect())), animated: true)
        } else {
            self.navigationController?.navigationBar.topItem?.title = "Karte bearbeiten"
            self.questionField.text = self.cardData.question
            self.answerField.text = self.cardData.answer
        }
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
