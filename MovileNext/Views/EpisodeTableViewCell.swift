//
//  EpisodeTableViewCell.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

class EpisodeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel?.textColor = UIColor.grayColor()
        textLabel?.font = UIFont.systemFontOfSize(15)
        
        detailTextLabel?.textColor = UIColor.mup_textColor()
        detailTextLabel?.font = UIFont.systemFontOfSize(18)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func loadEpisode(episode : Episode, season : Int) {
        
        textLabel?.text = String(format: "S%02dE%02d", season, episode.number)
        detailTextLabel?.text = episode.title
        
        if let first = episode.firstAired {
            
            if first.timeIntervalSince1970 > NSDate().timeIntervalSince1970 {
                
                detailTextLabel?.textColor = UIColor.lightGrayColor()
            }
        }
    }

}
