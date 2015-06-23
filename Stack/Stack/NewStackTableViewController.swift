//
//  NewStackTableViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 13.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class NewStackTableViewController: UITableViewController {

    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var nameField: UITextField!

    var collection = StackCollection.instance
    var cards: [Card] = []

    @IBAction func saveStack() {
        if self.nameField.text.isEmpty == true {
            return
        }
        
        var stack = Stack()
        stack.name = self.nameField.text
        stack.cards = self.cards
        
        let success : Bool = collection.saveStack(stack)

        if success == true {
            var alert = UIAlertController(
                title: "Speichern erfolgreich",
                message: "\"\(self.nameField.text)\" wurde erfolgreich gespeichert!",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func closeView(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @IBAction func unwindNewCardToList(segue: UIStoryboardSegue) {
        let source: CardDetailsTableViewController = segue.sourceViewController as! CardDetailsTableViewController

        if source.cardData != nil {
            self.cards.append(source.cardData)
        }        
    }
}
