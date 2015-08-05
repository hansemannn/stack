//
//  HomeViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 12.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit
import CoreData
import SnapKit

@IBDesignable
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var newStackButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBInspectable lazy var emptyContainerView = UIView()
    @IBInspectable lazy var emptyImageView = UIImageView()
    @IBInspectable lazy var emptyLabel = UILabel()
    
    var stacks = []
    var numberOfStacks: Int!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        self.stacks = PersistenceManager.sharedManager.findAllStacks()
        self.numberOfStacks = self.stacks.count
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.stacks = PersistenceManager.sharedManager.findAllStacks()
        self.numberOfStacks = self.stacks.count
        
        self.addUI()        
    }
    
    func addConstraints() {
        self.emptyContainerView.snp_makeConstraints { (make) -> Void in
            
            make.width.equalTo(225)
            make.height.equalTo(255)
            make.center.equalTo(self.view)
        }
        
        self.emptyImageView.snp_makeConstraints { (make) -> Void in
            
            if(ScreenSize.SCREEN_WIDTH > 320) {
                make.width.equalTo(221)
                make.height.equalTo(190)
                make.top.equalTo(0)
            } else {
                make.width.equalTo(150)
                make.height.equalTo(129)
                make.top.equalTo(55)
            }
            
            make.centerX.equalTo(self.emptyContainerView)
        }
        
        self.emptyLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(0)
            make.centerX.equalTo(self.emptyContainerView)
        }
    }

    func addUI() {
        self.newStackButton.layer.cornerRadius = 5.0
        
        if numberOfStacks == 0 {
            self.tableView.hidden = true
            self.emptyContainerView.hidden = false
            
            self.emptyImageView.image = UIImage(named: "EmptyStack")
            
            self.emptyLabel.text = "Noch kein Stapel\nvorhanden."
            self.emptyLabel.numberOfLines = 2
            self.emptyLabel.textAlignment = .Center
            self.emptyLabel.textColor = UIColor(rgba: "#d1d1d1")
            self.emptyLabel.font = UIFont(name: "CartoGothicStd-Bold", size: 22.0)

            self.emptyContainerView.addSubview(self.emptyImageView)
            self.emptyContainerView.addSubview(self.emptyLabel)
            
            self.view.addSubview(self.emptyContainerView)
            self.addConstraints()
        } else {
            self.emptyContainerView.hidden = true
            self.tableView.hidden = false
            self.tableView.reloadData()
        }
    }
    
    // MARK: - TableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recordCount = self.numberOfStacks
        
        return recordCount!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellData = self.stacks[indexPath.row] as? Stack
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("StackCell", forIndexPath: indexPath) as! StackTableViewCell
                
        cell.nameLabel.text = cellData!.name
        cell.numberOfCardsLabel.text = String(cellData!.cards.count)
        cell.stack = cellData
        cell.separatorInset = UIEdgeInsets(top: 0, left: 65, bottom: 0, right: 0)
        
        return cell
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        PersistenceManager.sharedManager.managedObjectContext.deleteObject(self.stacks[indexPath.row] as! NSManagedObject)
        PersistenceManager.sharedManager.persistAll()
        
        self.stacks = PersistenceManager.sharedManager.findAllStacks()
        self.numberOfStacks = self.stacks.count
        
        self.addUI()
    }
    
    // MARK: - Prepare for segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "NewStackSegue") {
            
            let naviVC: UINavigationController = segue.destinationViewController as! UINavigationController
            var newStackVC: NewStackTableViewController = naviVC.topViewController as! NewStackTableViewController
            let newStack = PersistenceManager.sharedManager.createStack()
            newStackVC.stack = newStack
        } else if(segue.identifier == "StackDetailSegue") {
            
            var indexPath = self.tableView.indexPathForSelectedRow()
            let cell = self.tableView.cellForRowAtIndexPath(indexPath!) as! StackTableViewCell
            
            var stackDetailsViewController: StackDetailsCollectionViewController = segue.destinationViewController as! StackDetailsCollectionViewController
            stackDetailsViewController.stack = cell.stack
            
            
        }
    }
}

