//
//  SeasonTableViewCell.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher
import FloatRatingView

class SeasonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var seasonTitle: UILabel!
    @IBOutlet weak var seasonNumEp: UILabel!
    @IBOutlet weak var ratingStars: FloatRatingView!
    @IBOutlet weak var ratingNumber: UILabel!
    
    var task : RetrieveImageTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if task != nil {
            task?.cancel()
        }
        seasonImage.image = nil
    }
    
    func loadSeason(season : Season) -> Void {
        
        let placeholder = UIImage(named: "poster")
        
        if let image = season.poster?.fullImageURL {
            task = seasonImage.kf_setImageWithURL(image, placeholderImage: placeholder)
        }
        else {
            seasonImage.image = placeholder
        }
        
        seasonTitle.text = "Season \(season.number)"
        if let n = season.episodeCount {
            seasonNumEp.text = "\(n) episodes"
        }
        else {
            seasonNumEp.text = "-"
        }
        
        if let rate = season.rating {
            ratingNumber.text = NSString(format: "%.01f", rate) as String
            ratingStars.rating = rate
        }
        else {
            ratingNumber.text = "-"
        }
    }
}
