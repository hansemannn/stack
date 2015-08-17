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
    var selectedItemIndex:NSIndexPath!
    
    /**
    Shows options to handle a stack
    
    :param: sender  The sender of the click event.
    
    :returns: void
    */
    @IBAction func showActionOptions(sender: AnyObject) -> Void {
        var options = UIAlertController(
            title: "Was möchtest du tun?",
            message: nil,
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        options.addAction(UIAlertAction(
            title: "Wecker einstellen [10 Sek PoC]",
            style: UIAlertActionStyle.Default,
            handler: {
                (action: UIAlertAction!) in
                
                var notification = UILocalNotification()
                notification.alertBody = "Eine neue Lernphase für \"\(self.stack.name)\" hat begonnen!"
                notification.fireDate = NSDate(timeIntervalSinceNow: 10)
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.userInfo = ["StackName": self.stack.name]
                notification.category = "myCategory"

                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                var alert = UIAlertController(title: "Wecker erfolgreich erstellt", message: "Dein Wecker für die nächste Lernrunde wurde erfolgreich gesetzt!", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
        }))
        
        options.addAction(UIAlertAction(
            title: "Neue Lernrunde",
            style: UIAlertActionStyle.Default,
            handler: {
                (action: UIAlertAction!) in
                var swipeController = SwipeStackViewController()
                swipeController.stack = self.stack
                self.presentViewController(swipeController, animated: true, completion: nil)
        }))
        
        options.addAction(UIAlertAction(
            title: "Abbrechen",
            style: UIAlertActionStyle.Cancel,
            handler: nil
        ))
        
        presentViewController(options, animated: true, completion: nil)
    }
    
    /**
    Adds a new card to the stack after creating it.
    
    :param: segue   The segue which triggered the delegate.
    
    :returns: void
    */
    @IBAction func unwindNewCardToStack(segue: UIStoryboardSegue) {
        let source: CardDetailsTableViewController = segue.sourceViewController as! CardDetailsTableViewController
        
        if source.cardData != nil {
            self.stack.addCard(source.cardData)
            PersistenceManager.sharedManager.persistAll()
            self.collectionView?.reloadData()
        }
    }
    
    /**
    Sets the view controller title.
    
    :param: animated   The decision of animating the opening of the view or not.
    
    :returns: void
    */
    override func viewDidAppear(animated: Bool) -> Void {
        var title: String!
        
        if stack.cards.count == 1 {
            title = "\(stack.name) (Eine Karte)"
        } else {
            title = "\(stack.name) (\(stack.cards.count) Karten)"
        }
        
        self.navigationController?.navigationBar.topItem?.title = title
        self.collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stack.cards.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("QuestionCell", forIndexPath: indexPath) as! CardCollectionViewCell

        let allCards: [Card] = self.stack.cards.allObjects as! [Card]
        cell.questionLabel.text = allCards[indexPath.row].question
        cell.card = allCards[indexPath.row]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedItemIndex = indexPath
    }
    
    // MARK: - Prepare for segue
    
    /**
    Opens a new view controller depending on the segue.
    
    :param: segue    The segue which is triggered by the sender
    :param: sender   The sender who triggered the event.
    
    :returns: void
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) -> Void {
        if segue.identifier == "ShowSwipeViewSegue" {
            let naviVC: UINavigationController = segue.destinationViewController as! UINavigationController
            var newStackVC: SwipeStackViewController = naviVC.topViewController as! SwipeStackViewController
            newStackVC.stack = self.stack
        } else if segue.identifier == "ShowDetailSegue" {
            var _sender:CardCollectionViewCell = sender as! CardCollectionViewCell

            let naviVC: UINavigationController = segue.destinationViewController as! UINavigationController
            var cardDetailsVC: CardDetailsTableViewController = naviVC.topViewController as! CardDetailsTableViewController
            cardDetailsVC.cardData = _sender.card
        }
    }
}
