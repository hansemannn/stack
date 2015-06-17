//
//  QuestionDetailsTableViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 14.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class QuestionDetailsTableViewController: UITableViewController {

    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func closeView(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deleteQuestion(sender: UIBarButtonItem) {
        var alert = UIAlertController(title: "Frage löschen", message: "Möchtest du die Frage wirklich löschen?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Unwiderruflich löschen", style: UIAlertActionStyle.Destructive, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.submitButton.layer.cornerRadius = 5.0
    }
}
