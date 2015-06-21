//
//  EpisodesListViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

class EpisodesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    private let httpClient = TraktHTTPClient()
    private var episodesList : [Episode] = []
    
    var selectedShow : Show?
    var seasonNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showEpisodes()
    }
    
    func showEpisodes() {
     
        if let showID = self.selectedShow?.identifiers.slug {
            
            httpClient.getEpisodes(showID, season: self.seasonNumber!, completion: {
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
        cell.loadEpisode(episode, season: seasonNumber!)
        
        return cell
    }
}
