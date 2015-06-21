//
//  ShowItemCollectionViewCell.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels
import Haneke

class ShowItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showLabel: UILabel!
    
    func loadShow(show : Show) {
        
        let placeholder = UIImage(named: "poster")
        
        if let image = show.poster?.fullImageURL {
            showImage.hnk_setImageFromURL(image, placeholder: placeholder)
        }
        else {
            showImage.image = placeholder
        }
        
        showLabel.text = show.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        showImage.hnk_cancelSetImage()
//        showImage.image = nil
    }
    
}
