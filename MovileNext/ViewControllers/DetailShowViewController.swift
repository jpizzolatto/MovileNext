//
//  DetailShowViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels
import FloatRatingView
import Kingfisher

class DetailShowViewController: UIViewController {
    
    @IBOutlet weak var showTitle: UINavigationItem!
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var likeHeart: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingStars: FloatRatingView!
    @IBOutlet weak var showYear: UILabel!
    
    private weak var overviewViewController : OverviewShowViewController!
    private weak var genresViewControler : ShowGenresViewController!
    private weak var seasonsViewController : SeasonsViewController!
    private weak var detailsViewController : ShowDetailsViewController!
    
    @IBOutlet weak var overviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var genresHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var seasonsHeightConstraint: NSLayoutConstraint!
    
    private let httpClient = TraktHTTPClient()
    
    var showID : String?
    var selectedShowTitle = ""
    
    var selectedShow : Show?
    var seasons : [Season] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTitle.title = selectedShowTitle
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        overviewHeightConstraint.constant = overviewViewController.intrinsicContentSize().height + 10
        seasonsHeightConstraint.constant = seasonsViewController.intrinsicContentSize().height + 30
        genresHeightConstraint.constant = genresViewControler.intrinsicContentSize().height + 10
        detailsHeightConstraint.constant = detailsViewController.intrinsicContentSize().height
    }
    
    // Loading one show before view appear, is this the rigth way?
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        httpClient.getShow(showID!, completion: {
            [weak self] result in
            
            if let show = result.value {
                self?.selectedShow = show
                
                self?.LoadShowContainer(show)
                
                // Reload the overview container
                self?.overviewViewController.selectedShow = show
                self?.overviewViewController.LoadShow()
                
                // Reload the Genres container
                self?.genresViewControler.selectedShow = show
                self?.genresViewControler.LoadGenres()
                
                self?.viewDidLayoutSubviews()
                
                if let showID = show.identifiers.slug {
                    
                    // Get the seasons for the show
                    self?.httpClient.getSeasons(showID, completion: {
                        [weak self] result in
                        
                        if let seasons = result.value {
                            self?.seasons = seasons
                            self?.seasons.sort { $0.number > $1.number }
                            
                            // Reload the seasons table
                            let listSeasons = self?.seasons
                            self?.seasonsViewController.ReloadTable(show, seasons: listSeasons!)
                            
                            // Reload the show details
                            self?.detailsViewController.selectedShow = show
                            self?.detailsViewController.seasons = self?.seasons
                            self?.detailsViewController.LoadDetails()
                            
                            self?.viewDidLayoutSubviews()
                        }
                    })
                }
            }
        })
    }
    
    func LoadShowContainer(show: Show) -> Void {
        
        let placeholder = UIImage(named: "bg")
        
        if let image = show.thumbImageURL {
            imageShow.kf_setImageWithURL(image, placeholderImage: placeholder)
        }
        else {
            imageShow.image = placeholder
        }
        
        if let rate = show.rating {
            ratingLabel.text = NSString(format: "%.01f", rate) as String
            ratingStars.rating = rate
        }
        else {
            ratingLabel.text = "-"
        }
        
        showYear.text = String(show.year)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == Segue.overview_container {
            
            overviewViewController = segue.destinationViewController as! OverviewShowViewController
            overviewViewController.selectedShow = selectedShow

        }
        else if segue == Segue.seasons_container {
            
            seasonsViewController = segue.destinationViewController as! SeasonsViewController
            seasonsViewController.selectedShow = selectedShow
            seasonsViewController.seasonsList = seasons
            
        }
        else if segue == Segue.genres_container {
            
            genresViewControler = segue.destinationViewController as! ShowGenresViewController
            genresViewControler.selectedShow = selectedShow
            
        }
        else if segue == Segue.details_container {
            
            detailsViewController = segue.destinationViewController as! ShowDetailsViewController
            detailsViewController.selectedShow = selectedShow
            detailsViewController.seasons = seasons
        }
    }
    
    

}
