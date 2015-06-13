//
//  NewStackTableViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 13.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class NewStackTableViewController: UITableViewController, StackCollectionLoadStackDelegate {

    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var nameField: UITextField!

    @IBAction func saveStack() {
        if self.nameField.text.isEmpty == true {
            return
        }
        
        let success : Bool = collection.saveStack(Stack(name: self.nameField.text, cards: []))

        if collection.saveStack(Stack(name: self.nameField.text!, cards: [])) {
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
    
    var collection = StackCollection.instance
    
    func loadStack(stack: Stack) {
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
        return 1
    }
}
