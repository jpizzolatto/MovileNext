//
//  ShowItemCollectionViewCell.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class ShowItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showLabel: UILabel!
    
    var task : RetrieveImageTask?
    
    func loadShow(show : Show) {
        
        let placeholder = UIImage(named: "poster")
        
        if let image = show.poster?.mediumImageURL {
            task = showImage.kf_setImageWithURL(image, placeholderImage: placeholder)
        }
        else {
            showImage.image = placeholder
        }
        
        showLabel.text = show.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if task != nil {
            task?.cancel()
        }
        showImage.image = nil
    }
    
}
