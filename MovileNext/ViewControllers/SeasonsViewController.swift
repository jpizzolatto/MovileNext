//
//  SeasonsViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

class SeasonsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedShow : Show?
    var seasonsList : [Season] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 110.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == Segue.show_episode {
            if let cell = sender as? UITableViewCell,
                indexPath = tableView.indexPathForCell(cell) {
                    
                    let vc = segue.destinationViewController as! EpisodesListViewController
                    vc.selectedShow = selectedShow
                    vc.seasonNumber = seasonsList[indexPath.row].number
                    
                    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.seasonsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = Reusable.SeasonCell.identifier!
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier,forIndexPath: indexPath) as! SeasonTableViewCell
        
        let season = seasonsList[indexPath.row]
        cell.loadSeason(season)
        
        return cell
    }
}
