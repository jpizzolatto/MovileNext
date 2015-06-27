//
//  ShowDetailsViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

class ShowDetailsViewController: UIViewController {
    
    @IBOutlet weak var broadcastingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var startedLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    
    var selectedShow : Show?
    var seasons : [Season] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set broadcast text
        if let network = selectedShow?.network {
            
            let broadText =  "Broadcastring: \(network)"
            
            var mutableBroad = NSMutableAttributedString(string: broadText, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 16.0)!])
            mutableBroad.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 16.0)!, range: NSRange(location:0, length:14))
            
            broadcastingLabel.attributedText = mutableBroad
        }
        else {
            broadcastingLabel.hidden = true
        }
        
        
        // Set Status text
        if let status = selectedShow?.status {
         
            let statusText =  "Status: \(status.rawValue.capitalizedString)"
            
            var mutableStatus = NSMutableAttributedString(string: statusText, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 16.0)!])
            mutableStatus.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 16.0)!, range: NSRange(location:0, length:7))
            
            statusLabel.attributedText = mutableStatus
        }
        else {
            statusLabel.hidden = true
        }
        
        // Set Seasons text
        let seasonText = "Seasons: \(seasons.filter { $0.number > 0 }.count)"
        
        var mutableSeason = NSMutableAttributedString(string: seasonText, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 16.0)!])
        mutableSeason.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 16.0)!, range: NSRange(location:0, length:8))
        
        seasonsLabel.attributedText = mutableSeason
        
        // Set started info text
        if let year = selectedShow?.year {
            
            let startedText = "Started in: \(year)"
            
            var mutableStarted = NSMutableAttributedString(string: startedText, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 16.0)!])
            mutableStarted.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 16.0)!, range: NSRange(location:0, length:11))
            
            startedLabel.attributedText = mutableStarted
        }
        else {
            startedLabel.hidden = true
        }
        
        // Set Country text
        if let country = selectedShow?.country {
            
            let countryText = "Country: \(country.uppercaseString)"
            
            var mutableCountry = NSMutableAttributedString(string: countryText, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 16.0)!])
            mutableCountry.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 16.0)!, range: NSRange(location:0, length:8))
            
            countryLabel.attributedText = mutableCountry
        }
        else {
            countryLabel.hidden = true
        }

        
        // Set homepage text
        if let page = selectedShow?.homepageURL {
            
            let homepageText = "Homepage: \(page)"
            
            var mutableHomepage = NSMutableAttributedString(string: homepageText, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 16.0)!])
            mutableHomepage.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 16.0)!, range: NSRange(location:0, length:9))
            
            homepageLabel.attributedText = mutableHomepage
        }
        else {
            homepageLabel.hidden = true
        }
    }
}
