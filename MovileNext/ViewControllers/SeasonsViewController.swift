//
//  SeasonsViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

protocol SeasonsViewControllerDelegate: class {
    func seasonsController(vc: SeasonsViewController, didSelectedSeason seasons: Season)
}

class SeasonsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ShowInternalViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate : SeasonsViewControllerDelegate?
    
    var selectedShow : Show?
    var seasonsList : [Season] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 110.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func intrinsicContentSize() -> CGSize {
        return tableView.contentSize
    }
    
    func ReloadTable(show: Show?, seasons: [Season]) -> Void {
        
        self.selectedShow = show
        self.seasonsList = seasons
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let season = seasonsList[indexPath.row]
        delegate?.seasonsController(self, didSelectedSeason: season)
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
