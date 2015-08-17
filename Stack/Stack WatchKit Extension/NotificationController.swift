//
//  NotificationController.swift
//  Stack WatchKit Extension
//
//  Created by Hans Knöchel on 28.07.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {
    
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        
        println("test")
        completionHandler(.Custom)
    }
}
