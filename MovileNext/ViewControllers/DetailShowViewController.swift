//
//  DetailShowViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

class DetailShowViewController: UIViewController {
    
    @IBOutlet weak var showTitle: UINavigationItem!
    
    private let httpClient = TraktHTTPClient()
    
    var showID : String?
    var selectedShowTitle = ""
    
    var selectedShow : Show?
    var seasons : [Season] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTitle.title = selectedShowTitle
        
        httpClient.getSeasons(showID!, completion: {
            [weak self] result in
            
            if let seasons = result.value {
                self?.seasons = seasons
                self?.seasons.sort { $0.number > $1.number }
            }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        httpClient.getShow(showID!, completion: {
            [weak self] result in
            
            if let show = result.value {
                self?.selectedShow = show
            }
        })
    } 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == Segue.show_overview {
            
            let vc = segue.destinationViewController as! OverviewShowViewController
            vc.selectedShow = selectedShow

        }
        else if segue == Segue.show_seasons {
            
            let vc = segue.destinationViewController as! SeasonsViewController
            vc.selectedShow = selectedShow
            vc.seasonsList = seasons
            
        }
        else if segue == Segue.show_genres {
            
            let vc = segue.destinationViewController as! ShowGenresViewController
            vc.selectedShow = selectedShow
            
        }
        else if segue == Segue.show_details {
            
            let vc = segue.destinationViewController as! ShowDetailsViewController
            vc.selectedShow = selectedShow
            vc.seasons = seasons
        }
    }
    
    

}
