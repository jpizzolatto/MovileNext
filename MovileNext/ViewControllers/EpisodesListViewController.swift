//
//  EpisodesListViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels
import FloatRatingView
import Kingfisher

class EpisodesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    @IBOutlet weak var seasonPoster: UIImageView!
    @IBOutlet weak var seasonRatingNumber: UILabel!
    @IBOutlet weak var seasonRatingStar: FloatRatingView!
    @IBOutlet weak var seasonYear: UILabel!
    @IBOutlet weak var seasonImage: UIImageView!
    
    private let httpClient = TraktHTTPClient()
    private var episodesList : [Episode] = []
    
    var selectedSeason : Season?
    var selectedShow : Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showEpisodes()
        
        if let season = selectedSeason {
            seasonYear.text = "Season \(season.number)"
        }
        
        let placeholder = UIImage(named: "poster")?.darkenImage()
        if let image = selectedSeason?.poster?.fullImageURL {
            seasonImage.kf_setImageWithURL(image, placeholderImage: placeholder)
        }
        else {
            seasonImage.image = placeholder
        }
        
        let placeholderPoster = UIImage(named: "bg")?.darkenImage()
        if let image = selectedShow?.thumbImageURL {
            seasonPoster.kf_setImageWithURL(
                image,
                placeholderImage: placeholderPoster,
                optionsInfo: nil,
                progressBlock: nil,
                completionHandler : { (imageLoaded, _, _,  _) in
                    self.seasonPoster.image = imageLoaded!.darkenImage()
            })
        }
        else {
            seasonPoster.image = placeholderPoster
        }
        
        if let rate = selectedSeason?.rating {
            seasonRatingNumber.text = NSString(format: "%.01f", rate) as String
            seasonRatingStar.rating = rate
        }
    }
    
    func showEpisodes() {
     
        if let showID = self.selectedShow?.identifiers.slug,
               season = self.selectedSeason {
            
            httpClient.getEpisodes(showID, season: season.number, completion: {
                [weak self] result in
                
                if let episodes = result.value {
                    
                    self?.episodesList = episodes
                    self?.tableVIew.reloadData()
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == Segue.show_single_episode {
            if let cell = sender as? UITableViewCell,
                   indexPath = tableVIew.indexPathForCell(cell) {
                    
                    let vc = segue.destinationViewController as! EpisodeViewController
                    vc.selectedEpisode = episodesList[indexPath.row]
                    
                    self.tableVIew.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = Reusable.EpisodeCell.identifier!

        let cell = tableView.dequeueReusableCellWithIdentifier(identifier,forIndexPath: indexPath) as! EpisodeTableViewCell
        
        let episode = episodesList[indexPath.row]
        cell.loadEpisode(episode, season: selectedSeason!.number)
        
        return cell
    }
}
