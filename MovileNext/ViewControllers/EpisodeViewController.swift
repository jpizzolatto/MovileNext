//
//  EpisodeViewController.swift
//  MovileNext
//
//  Created by User on 13/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher


class EpisodeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewText: UITextView!
    
    var selectedEpisode : Episode?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewText.textContainer.lineFragmentPadding = 0
        overviewText.textContainerInset = UIEdgeInsetsZero
        
        titleLabel.text = selectedEpisode?.title
        overviewText.text = selectedEpisode?.overview
        
        let placeholder = UIImage(named: "bg")?.darkenImage()
        
        if let image = selectedEpisode?.screenshot?.fullImageURL {
            imageView.kf_setImageWithURL(
                image,
                placeholderImage: placeholder,
                optionsInfo: nil,
                progressBlock: nil,
                completionHandler : { (imageLoaded, error, _,  _) in
                    self.imageView.image = imageLoaded!.darkenImage()
            })
        }
        else {
            imageView.image = placeholder
        }
    }
    
    @IBAction func sharePressed(sender: UIBarButtonItem) {
        
        let url = NSURL(string: "http://www.apple.com")!
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        presentViewController(vc, animated: true, completion: nil)
    }

}
