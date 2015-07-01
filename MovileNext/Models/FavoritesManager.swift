//
//  FavoritesManager.swift
//  MovileNext
//
//  Created by User on 28/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import Foundation

class FavoritesManager {
    
    private var userDefaults = NSUserDefaults.standardUserDefaults()
    
    var favoriteIdentifiers: Set<Int> {
        
        get {
            var ids: AnyObject? = userDefaults.objectForKey("ids")
            
            var setIds : Set<Int> = []
            
            if ids != nil {
                for id in ids as! [Int] {
                    setIds.insert(id)
                }
            }
            
            return setIds
        }
    }
    
    func addIdentifier(identifier: Int) {
        
        var ids: AnyObject? = userDefaults.objectForKey("ids")
        var idsArray : [Int] = []
        
        if ids != nil {
            
            idsArray = ids as! [Int]
            idsArray.append(identifier)
        }
        else {
            idsArray.append(identifier)
        }
        
        userDefaults.setObject(idsArray, forKey: "ids")
        userDefaults.synchronize()
    }
    
    func removeIdentifier(identifier: Int) {
        
        var ids: AnyObject? = userDefaults.objectForKey("ids")
        
        if ids != nil {
            
            var idsArray = ids as! [Int]
            
            if let index = find(idsArray, identifier) {
                idsArray.removeAtIndex(index)
                
                userDefaults.setObject(idsArray, forKey: "ids")
                userDefaults.synchronize()
            }
        }

    }
}