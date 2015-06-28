//
//  ShowDetailsViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

class ShowDetailsViewController: UIViewController, ShowInternalViewController {
    
    @IBOutlet weak var broadcastingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var startedLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    
    var selectedShow : Show?
    var seasons : [Season]?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadDetails()
    }
    
    func intrinsicContentSize() -> CGSize {
        let h1 = broadcastingLabel.intrinsicContentSize().height + broadcastingLabel.bounds.height
        let h2 = statusLabel.intrinsicContentSize().height + statusLabel.bounds.height
        let h3 = seasonsLabel.intrinsicContentSize().height + seasonsLabel.bounds.height
        let h4 = startedLabel.intrinsicContentSize().height + startedLabel.bounds.height
        let h5 = countryLabel.intrinsicContentSize().height + countryLabel.bounds.height
        let h6 = homepageLabel.intrinsicContentSize().height + homepageLabel.bounds.height
        
        return CGSize(width: 0, height: h1 + h2 + h3 + h4 + h5 + h6)
    }
    
    func LoadDetails() -> Void {
        
        if let show = self.selectedShow,
               seasons = self.seasons {
                
            // Set broadcast text
            if let network = show.network {
                
                let broadText =  "Broadcastring: \(network)"
                
                var mutableBroad = NSMutableAttributedString(string: broadText, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 16.0)!])
                mutableBroad.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 16.0)!, range: NSRange(location:0, length:14))
                
                broadcastingLabel.attributedText = mutableBroad
            }
            else {
                broadcastingLabel.hidden = true
            }
            
            
            // Set Status text
            if let status = show.status {
                
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
            let startedText = "Started in: \(show.year)"
            
            var mutableStarted = NSMutableAttributedString(string: startedText, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 16.0)!])
            mutableStarted.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 16.0)!, range: NSRange(location:0, length:11))
            
            startedLabel.attributedText = mutableStarted
            
            // Set Country text
            if let country = show.country {
                
                let countryText = "Country: \(country.uppercaseString)"
                
                var mutableCountry = NSMutableAttributedString(string: countryText, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 16.0)!])
                mutableCountry.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 16.0)!, range: NSRange(location:0, length:8))
                
                countryLabel.attributedText = mutableCountry
            }
            else {
                countryLabel.hidden = true
            }
            
            
            // Set homepage text
            if let page = show.homepageURL {
                
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
}
