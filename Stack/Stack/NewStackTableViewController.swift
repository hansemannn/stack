//
//  NewStackTableViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 13.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class NewStackTableViewController: UITableViewController, UITextFieldDelegate {

    var stack: Stack!
    
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var nameField: UITextField!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.layer.cornerRadius = 5.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBActions
    
    /**
    Saves a new stack.
    
    :returns: void
    */
    @IBAction func saveStack() -> Void {
        if self.nameField.text.isEmpty == true {
            return
        }
        
        self.stack.name = self.nameField.text
        
        PersistenceManager.sharedManager.persistAll()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
    Closes the currently opened view controller
    
    :param: sender  The sender which triggered the click event.
    
    :returns: void
    */
    @IBAction func closeView(sender: UIBarButtonItem) -> Void {
        self.stack.managedObjectContext?.deleteObject(self.stack)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Text view delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    /**
    Adds a new card to the stack after creating it.
    
    :param: segue   The segue which triggered the delegate.
    
    :returns: void
    */
    @IBAction func unwindNewCardToList(segue: UIStoryboardSegue) -> Void {
        let source: CardDetailsTableViewController = segue.sourceViewController as! CardDetailsTableViewController
        
        if source.cardData != nil {
            self.stack.addCard(source.cardData)
            
            var cell: UITableViewCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!
            cell.detailTextLabel!.text = "\(self.stack.cards.count) Karten"
            self.tableView.reloadData()
        }
    }
}
