//
//  FavoritesManager.swift
//  MovileNext
//
//  Created by User on 28/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import Foundation

class FavoritesManager {
    
    let favoritesChangedNotificationName = "changed"
    private var userDefaults = NSUserDefaults.standardUserDefaults()
    
    var favoriteIdentifiers: Set<String> {
        
        get {
            var ids: AnyObject? = userDefaults.objectForKey("ids")
            
            var setIds : Set<String> = []
            
            if ids != nil {
                for id in ids as! [String] {
                    setIds.insert(id)
                }
            }
            
            return setIds
        }
    }
    
    func addIdentifier(identifier: String) {
        
        var ids: AnyObject? = userDefaults.objectForKey("ids")
        var idsArray : [String] = []
        
        if ids != nil {
            
            idsArray = ids as! [String]
            idsArray.append(identifier)
        }
        else {
            idsArray.append(identifier)
        }
        
        userDefaults.setObject(idsArray, forKey: "ids")
        userDefaults.synchronize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(favoritesChangedNotificationName, object: nil)
    }
    
    func removeIdentifier(identifier: String) {
        
        var ids: AnyObject? = userDefaults.objectForKey("ids")
        
        if ids != nil {
            
            var idsArray = ids as! [String]
            
            if let index = find(idsArray, identifier) {
                idsArray.removeAtIndex(index)
                
                userDefaults.setObject(idsArray, forKey: "ids")
                userDefaults.synchronize()
            }
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(favoritesChangedNotificationName, object: nil)

    }
}