//
//  HomeViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 12.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var newStackButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBInspectable lazy var emptyContainerView = UIView()
    @IBInspectable lazy var emptyImageView = UIImageView()
    @IBInspectable lazy var emptyLabel = UILabel()
    
    var stackCollection = StackCollection.instance
    var numberOfStacks: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.numberOfStacks = stackCollection.getStacks()?.count
        self.addUI()
        
        println("\(numberOfStacks) Stapel vorhanden")
    }
    
    func addConstraints() {
        self.emptyContainerView.snp_makeConstraints { (make) -> Void in
            
            make.width.equalTo(225)
            make.height.equalTo(255)
            make.center.equalTo(self.view)
        }
        
        self.emptyImageView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(221)
            make.height.equalTo(190)
            make.top.equalTo(0)
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recordCount = self.stackCollection.getStacks()?.count
        
        return recordCount!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var stacks : [Stack] = self.stackCollection.getStacks()!
        let cellData = stacks[indexPath.row]
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("StackCell", forIndexPath: indexPath) as! StackTableViewCell
        
        cell.nameLabel.text = cellData.name
        cell.numberOfCardsLabel.text = String(cellData.cards.count)
        cell.numberOfCardsView.layer.cornerRadius = 20.0
        
        return cell
    }
}

