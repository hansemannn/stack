//
//  StackDetailsCollectionViewController.swift
//  Stack
//
//  Created by Hans Knöchel on 14.06.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

class StackDetailsCollectionViewController: UICollectionViewController {
    
    var stackCollection = StackCollection.instance
    var stack : Stack!
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15//stack.cards.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("QuestionCell", forIndexPath: indexPath) as! QuestionCollectionViewCell
        
        cell.questionLabel.text = "Test"
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
}
