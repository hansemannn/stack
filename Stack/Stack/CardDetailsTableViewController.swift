//
//  CardDetailsTableViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 14.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class CardDetailsTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBOutlet weak var questionField: UITextView!
    @IBOutlet weak var answerField: UITextView!

    var cardData: Card!
    var isNewCard: Bool = true
   
    @IBAction func closeView(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
    Deletes a card after showing an destructive alert dialog
    
    :param: sender  The sender of the action
    
    :returns: void
    */
    @IBAction func deleteCard(sender: UIBarButtonItem) -> Void {
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

    override func viewDidLoad() {
        self.submitButton.layer.cornerRadius = 5.0
    }
    
    /**
    Sets the view controller title.
    
    :param: animated   The decision of animating the opening of the view or not.
    
    :returns: void
    */
    override func viewWillAppear(animated: Bool) {
        
        self.isNewCard = self.cardData == nil
        
        if self.isNewCard {
            self.navigationController?.navigationBar.topItem?.title = "Neue Karte"
            self.navigationItem.setRightBarButtonItem(UIBarButtonItem(customView: UIView(frame: CGRect())), animated: true)
        } else {
            self.navigationController?.navigationBar.topItem?.title = "Karte bearbeiten"
            self.questionField.text = self.cardData.question
            self.answerField.text = self.cardData.answer
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.questionField.delegate = self
        self.answerField.delegate = self
    }
    
    /**
    Sets the card to be used from the segue
    
    :returns: void
    */
    func saveCard() -> Void {
        
        var card: Card = PersistenceManager.sharedManager.createCard()
        card.question = questionField.text
        card.answer = answerField.text
                
        self.cardData = card
    }

    // MARK: - Text view delegate

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }

    // MARK: - Segue delegate
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.saveCard()
    }
}
