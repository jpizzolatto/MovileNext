//
//  AppDelegate.swift
//  MovileNext
//
//  Created by User on 6/13/15
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        let apperance = UINavigationBar.appearance()
        apperance.barTintColor = UIColor.mup_orangeColor()
        
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        apperance.titleTextAttributes = attrs
        apperance.tintColor = UIColor.whiteColor()
        
        return true
    }
    
}
