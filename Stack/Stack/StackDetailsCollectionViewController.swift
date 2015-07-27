//
//  StackDetailsCollectionViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 14.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class StackDetailsCollectionViewController: UICollectionViewController {
    
    var stack : Stack!
    
    @IBAction func unwindNewCardToStack(segue: UIStoryboardSegue) {
        let source: CardDetailsTableViewController = segue.sourceViewController as! CardDetailsTableViewController
        
        if source.cardData != nil {
            self.stack.addCard(source.cardData)
            PersistenceManager.sharedManager.persistAll()
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        var title: String!
        
        if(stack.cards.count == 1) {
            title = "\(stack.name) (Eine Karte)"
        } else {
            title = "\(stack.name) (\(stack.cards.count) Karten)"
        }
        
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stack.cards.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("QuestionCell", forIndexPath: indexPath) as! CardCollectionViewCell

        let allCards: [Card] = self.stack.cards.allObjects as! [Card]
        cell.questionLabel.text = allCards[indexPath.row].question
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    // MARK: - Prepare for segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowSwipeViewSegue") {
            
            let naviVC: UINavigationController = segue.destinationViewController as! UINavigationController
            var newStackVC: SwipeStackViewController = naviVC.topViewController as! SwipeStackViewController
            let newStack = PersistenceManager.sharedManager.createStack()
            newStackVC.stack = self.stack
        }
    }
}
